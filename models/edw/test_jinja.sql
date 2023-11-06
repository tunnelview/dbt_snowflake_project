{%- set dept_names = ['hr','sales','others'] -%}

with dept as (
select * from dbt_dev.src.seed_dept
),
final as (
select
dept_id,
{% for dept_nm in dept_names -%}

case when dept_name = '{{ dept_nm }}' then 1 else 0 end as {{ dept_nm }}_flag

{%- if loop.first -%}
,
{% endif -%}

{%- endfor %}
from dept

)
select * from final