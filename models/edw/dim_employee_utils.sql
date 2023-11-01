select 
{{ dbt_utils.generate_surrogate_key(['EMPLOYEE_ID']) }},
EMPLOYEE_ID ,
EMPLOYEE_NAME ,
DEPARTMENT_ID ,
EMAIL ,
PHONE ,
ADDRESS ,
HIRE_DATE ,
EMPLOYMENT_STATUS,
MD5_COLUMN,
current_timestamp as SNOW_INSERT_TIME,
current_timestamp as SNOW_UPDATE_TIME
FROM {{ ref('stg_dim_employee')}}