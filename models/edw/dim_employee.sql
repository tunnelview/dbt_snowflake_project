{{
    config(
        materialized= 'incremental', 
        unique_key='EMPLOYEE_ID',
        incremental_strategy='merge'
        
    ) 
}} --its not a drop and create, infact it is merge. merge(scd1), append only, add/delete

--post_hook="update dbt_dev.src.employee set phone = '77784663413' where employee_id = 3;",
        --pre_hook="update dbt_dev.src.employee set phone = '45784656744' where employee_id = 3"


{% if is_incremental() %}
    with max_user_key AS(
        select max(user_key) as max_user_key from {{ this }}
    ) -- for migration project, there are two types of load- history load and incremental load.


    
    select
        --CAST(ROW_NUMBER() OVER (ORDER BY EMPLOYEE_ID) as NUMBER(38,0)) as USER_KEY ,
    nvl(dim.USER_KEY,mx.max_user_key + ROW_NUMBER() OVER (order by stg.EMPLOYEE_ID)) as USER_KEY,
    stg.EMPLOYEE_ID ,
    stg.EMPLOYEE_NAME ,
    stg.DEPARTMENT_ID ,
    stg.EMAIL ,
    stg.PHONE ,
    stg.ADDRESS ,
    stg.HIRE_DATE ,
    stg.EMPLOYMENT_STATUS,
    stg.MD5_COLUMN,
    nvl(dim.SNOW_INSERT_TIME,current_timestamp) as SNOW_INSERT_TIME, -- the original insertion time.
    current_timestamp as SNOW_UPDATE_TIME -- the time when the record is getting updated.
    FROM {{ ref('stg_dim_employee')}} stg
    LEFT JOIN {{ this }} dim
    ON nvl(stg.EMPLOYEE_ID,0) = nvl(dim.EMPLOYEE_ID,0)
    CROSS JOIN max_user_key mx
    Where nvl(stg.MD5_COLUMN,'') <> nvl(dim.MD5_COLUMN,'')--- to identify whether this is incremental in nature.

{% else %}
    select
    CAST(ROW_NUMBER() OVER (ORDER BY EMPLOYEE_ID) as NUMBER(38,0)) as USER_KEY ,
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

{% endif %}

-- Post hook and pre hook -- It allows you to execute sql statements just before or just after the 
--execution of the model.
--Today - How can we configure the above?

--

