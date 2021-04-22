
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
        _variation as variation_id,  --Should we request this be added to the ERD?
        campaign_id,
        timestamp as occurred_at,
        -- don't include datetime... --Should this comment be removed?
        flow_id,
        flow_message_id,
        id as event_id,
        metric_id,
        person_id,
        type,
        uuid,
        property_value as numeric_value 
        /*******************
        Since `property_value` is a custom field we should probably add wording in the README 
        that this field is included by default and will not need to be added within the variable.

        Additionally, should we maybe consider adding something to the README that this field
        is required in order for the package, and downstream models, to effectively generate the
        final models? Finally, is there Klaviyo documentation stating that `property_value` is always
        the field which will contain the numeric value associated with the event 
        (ie the dollars associated with a purchase)?
        *******************/

        {{ fivetran_utils.fill_pass_through_columns('klaviyo__event_pass_through_columns') }}
    
    from fields
    where not coalesce(_fivetran_deleted, false)
)

select * from final
