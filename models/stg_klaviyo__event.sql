
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
        {{ fivetran_utils.add_dbt_source_relation() }}
    from base
),

rename as (
    
    select 
        _variation as variation_id,
        campaign_id,
        cast(timestamp as {{ dbt_utils.type_timestamp() }} ) as occurred_at,
        flow_id,
        flow_message_id,
        id as event_id,
        metric_id,
        person_id,
        type,
        uuid,
        property_value as numeric_value,
        _fivetran_synced

        {{ fivetran_utils.fill_pass_through_columns('klaviyo__event_pass_through_columns') }}
        {{ fivetran_utils.source_relation() }}

    from fields
    where not coalesce(_fivetran_deleted, false)
),

final as (
    
    select 
        *,
        cast( {{ dbt_utils.date_trunc('day', 'occurred_at') }} as date) as occurred_on

    from rename

)

select * from final
