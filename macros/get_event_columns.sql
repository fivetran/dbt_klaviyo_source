{% macro get_event_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "_variation", "datatype": dbt_utils.type_string()},
    {"name": "campaign_id", "datatype": dbt_utils.type_string()},
    {"name": "datetime", "datatype": dbt_utils.type_timestamp()},
    {"name": "flow_id", "datatype": dbt_utils.type_string()},
    {"name": "flow_message_id", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "metric_id", "datatype": dbt_utils.type_string()},
    {"name": "person_id", "datatype": dbt_utils.type_string()},
    {"name": "timestamp", "datatype": dbt_utils.type_timestamp()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "uuid", "datatype": dbt_utils.type_string()},
    {"name": "property_value", "datatype": dbt_utils.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('klaviyo__event_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}
