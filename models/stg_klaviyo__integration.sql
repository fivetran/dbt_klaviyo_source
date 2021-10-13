
with base as (

    select * 
    from {{ ref('stg_klaviyo__integration_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_klaviyo__integration_tmp')),
                staging_columns=get_integration_columns()
            )
        }}
        {{ add_dbt_source_relation() }}
    from base
),

final as (
    
    select 
        category,
        id as integration_id,
        name as integration_name

      {{ fivetran_utils.source_relation() }}

    from fields
    where not coalesce(_fivetran_deleted, false)
)

select * from final