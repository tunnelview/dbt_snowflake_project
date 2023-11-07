select
CC_CALL_CENTER_ID ,
CC_MANAGER ,
CC_COUNTRY ,
CC_TAX_PERCENTAGE * 100 as CC_TAX_PERCENTAGE
from {{ source('src', 'call_center_test') }}