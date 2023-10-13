
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
        {{ fivetran_utils.source_relation(
            union_schema_variable='klaviyo_union_schemas', 
            union_database_variable='klaviyo_union_databases') 
        }}
    from base
),

final as (
    
    select 
        category,
        cast(id as {{ dbt.type_string() }} ) as integration_id,
        name as integration_name,
        source_relation

    from fields
    where not coalesce(_fivetran_deleted, false)
)

select * from final