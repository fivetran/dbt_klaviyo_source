
with base as (

    select * 
    from {{ ref('stg_klaviyo__event_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_klaviyo__event_tmp')),
                staging_columns=get_event_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _variation as variation,
        campaign_id,
        coalesce(datetime, timestamp) as occurred_at,
        flow_id,
        flow_message_id,
        id as event_id,
        metric_id,
        person_id,
        type,
        uuid

        {{ fivetran_utils.fill_pass_through_columns('klaviyo__event_pass_through_columns') }}
    
    from fields
    where not coalesce(_fivetran_deleted, false)
)

select * from final
