select * from {{ ref('dim_employee')}}
--where 1=1 -- always true
where department_id >999


select * from {{ ref('dim_employee')}}
--where 1=1 -- always true
where EMAIL not like '%com'


