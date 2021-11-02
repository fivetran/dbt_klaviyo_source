
with base as (

    select * 
    from {{ ref('stg_klaviyo__person_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_klaviyo__person_tmp')),
                staging_columns=get_person_columns()
            )
        }}
        {{ fivetran_utils.add_dbt_source_relation() }}
    from base
),

final as (
    
    select 
        id as person_id,
        address_1,
        address_2,
        city,
        country,
        zip,
        created as created_at,
        email,
        first_name || ' ' || last_name as full_name,
        latitude,
        longitude,
        organization,
        phone_number,
        region, -- state in USA
        timezone,
        title,
        updated as updated_at
        
        
        {{ fivetran_utils.fill_pass_through_columns('klaviyo__person_pass_through_columns') }}
        {{ fivetran_utils.source_relation() }}

    from fields
    where not coalesce(_fivetran_deleted, false)
)

select * from final