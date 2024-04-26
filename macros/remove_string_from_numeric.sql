{% macro remove_string_from_numeric(column_name) %}

{% if target.type == 'bigquery' %}
    cast(regexp_replace(cast({{ column_name }} as {{ dbt.type_string() }}), r'[^0-9.]*', '') as {{ dbt.type_numeric() }})
{% elif target.type == 'postgres' %}
    cast(regexp_replace(cast({{ column_name }} as {{ dbt.type_string() }}), '[^0-9.]*', '', 'g') as {{ dbt.type_numeric() }})
{% else %}
    cast(regexp_replace(cast({{ column_name }} as {{ dbt.type_string() }}), '[^0-9.]*', '') as {{ dbt.type_numeric() }})
{% endif %}

{% endmacro %}