{% macro get_flow_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "created", "datatype": dbt_utils.type_timestamp()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "trigger", "datatype": dbt_utils.type_string(), "quote": True},
    {"name": "updated", "datatype": dbt_utils.type_timestamp()},
    {"name": "customer_filter", "datatype": dbt_utils.type_string()}
] %}

/*******************
  Did we previously settle on the reserved words to be handled within the macro so the staging
  model doesn't have additional complexity? I checked our HubSpot `get_email_event_sent_columns` and 
  noticed we handle this reserved words using the below in the macro. Then we are able to set "flow_trigger"
  within the staging model without needing a conditional in the staging model. 

  Both will work, but forgot what we decided was the approach to use?
*******************
{% if target.type == 'snowflake' %}
 {{ columns.append({"name": "TRIGGER", "datatype": dbt_utils.type_string(), "quote": True, "alias": "flow_trigger"}) }}
{% else %}
 {{ columns.append({"name": "trigger", "datatype": dbt_utils.type_string(), "quote": True, "alias": "flow_trigger"}) }}
{% endif %}
*******************/

{{ return(columns) }}

{% endmacro %}
