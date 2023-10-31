select * from {{ ref('dim_employee')}}
--where 1=1 -- always true
where EMAIL not like '%com'