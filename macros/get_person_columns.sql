{% macro get_person_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "address_1", "datatype": dbt_utils.type_string()},
    {"name": "address_2", "datatype": dbt_utils.type_string()},
    {"name": "city", "datatype": dbt_utils.type_string()},
    {"name": "country", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "email", "datatype": dbt_utils.type_string()},
    {"name": "first_name", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "last_name", "datatype": dbt_utils.type_string()},
    {"name": "latitude", "datatype": dbt_utils.type_float()},
    {"name": "longitude", "datatype": dbt_utils.type_float()},
    {"name": "organization", "datatype": dbt_utils.type_string()},
    {"name": "phone_number", "datatype": dbt_utils.type_string()},
    {"name": "region", "datatype": dbt_utils.type_string()},
    {"name": "timezone", "datatype": dbt_utils.type_string()},
    {"name": "title", "datatype": dbt_utils.type_string()},
    {"name": "updated", "datatype": dbt_utils.type_timestamp()},
    {"name": "zip", "datatype": dbt_utils.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('klaviyo__person_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}
