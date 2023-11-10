with dept as (
select * from dbt_dev.src.seed_dept
),
final as (
select
dept_id,
case when DEPT_NAME = 'hr' then 1 else 0 end as HR_FLAG,
case when DEPT_NAME = 'sales' then 1 else 0 end as SALES_FLAG,
case when DEPT_NAME = 'others' then 1 else 0 end as OTHERS_FLAG
from dept
)
select * from final