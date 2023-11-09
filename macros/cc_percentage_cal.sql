{% macro cc_percentage_cal(column_name) -%}
{{ column_name }} * 100
{%- endmacro %}