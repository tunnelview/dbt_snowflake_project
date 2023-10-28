select * from {{ ref('dim_employee')}}
where 1=1