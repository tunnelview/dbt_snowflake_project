
{% snapshot dim_employee_history %} -- built in macro that helps users to create scd2 logic based on 
--configurations we provide.

{{
config(
unique_key= 'EMPLOYEE_ID',
strategy='check',
check_cols=['md5_column']
)

}}

select * from {{ ref('dim_employee')}}

{% endsnapshot %}