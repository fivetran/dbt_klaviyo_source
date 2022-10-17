{% macro get_flow_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "created", "datatype": dbt.type_timestamp()},
    {"name": "id", "datatype": dbt.type_string()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "trigger", "datatype": dbt.type_string(), "quote": True},
    {"name": "updated", "datatype": dbt.type_timestamp()},
    {"name": "customer_filter", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
