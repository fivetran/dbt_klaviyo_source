{% macro get_flow_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "trigger", "datatype": dbt_utils.type_string()},
    {"name": "updated", "datatype": dbt_utils.type_timestamp()},
    {"name": "customer_filter", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
