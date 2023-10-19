WITH CTE AS
(
SELECT
EMPLOYEE_ID ,
EMPLOYEE_NAME ,
DEPARTMENT_ID ,
EMAIL ,
PHONE ,
ADDRESS ,
HIRE_DATE ,
EMPLOYMENT_STATUS
FROM {{source('src','employee')}} -- this is where the table is referred but not managed or created by dbt, 
)--rather in snowflake.

-- Main SELECT
SELECT
CAST(EMPLOYEE_ID as INTEGER) as EMPLOYEE_ID , -- dbt expects the column name, if you are doing any changes to the column name, using alias as. If the column data type is not modified, it will pick up the default.
EMPLOYEE_NAME ,
CAST(DEPARTMENT_ID as INTEGER) as DEPARTMENT_ID ,
EMAIL ,
CAST( PHONE as INTEGER) as PHONE ,
ADDRESS ,
HIRE_DATE ,
EMPLOYMENT_STATUS,
md5(nvl(cast(EMPLOYEE_NAME as varchar()),'')||nvl(cast(DEPARTMENT_ID as varchar()),'')||nvl(cast(EMAIL as varchar()),'')||nvl(cast(PHONE as varchar()),'')||nvl(cast(ADDRESS as varchar()),'')||nvl(cast(HIRE_DATE as varchar()),'')||nvl(cast(EMPLOYMENT_STATUS as varchar()),'') ) as md5_column,
current_timestamp as SNOW_INSERT_TIME, -- This is identify the latest records, based on time stamps.
current_timestamp as SNOW_UPDATE_TIME -- the most recent time the record was updated in the target platform.
from CTE

--nvl is used to handle null values
--md5 or hashvalue generates a 16 digit number 
---line number 25, 26, 27 are metadata columns.
-- ref is used by dbt to maintain or refer to a model.
-- this -- to refer to the current model.