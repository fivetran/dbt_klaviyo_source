{% macro get_campaign_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "campaign_type", "datatype": dbt_utils.type_string()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "email_template_id", "datatype": dbt_utils.type_string()},
    {"name": "from_email", "datatype": dbt_utils.type_string()},
    {"name": "from_name", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "is_segmented", "datatype": "boolean"},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "send_time", "datatype": dbt_utils.type_timestamp()},
    {"name": "sent_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "status_id", "datatype": dbt_utils.type_string()},
    {"name": "status_label", "datatype": dbt_utils.type_string()},
    {"name": "subject", "datatype": dbt_utils.type_string()},
    {"name": "updated", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}
