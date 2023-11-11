{% macro grant_ops(schema=target.schema, role=target.role) %}

{% set custom_sql %}
use role sysadmin;
grant usage on schema {{ schema }} to role {{ role }};
grant select on all tables in schema {{ schema }} to role {{ role }};
grant select on all views in schema {{ schema }} to role {{ role }};
{% endset %}


{{ log('providing grants on tables and views in schema ' ~ schema ~ 'to role ' ~ role, info = True)}}
{% do run_query(custom_sql)%}
{{ log('Grants provided', info = True)}}

{% endmacro %}

