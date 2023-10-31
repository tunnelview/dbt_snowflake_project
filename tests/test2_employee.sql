select 'test1',count(*) from {{ ref('dim_employee')}}
--where 1=1 -- always true
where EMAIL not like '%com'
group by 1 
having count(*)> 0






