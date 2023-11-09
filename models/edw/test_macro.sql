select
CC_CALL_CENTER_ID,
CC_MANAGER ,
CC_COUNTRY ,
CC_TAX_PERCENTAGE as CC_TAX_PERCENTAGE_Actual
{{ cc_percentage_cal('CC_TAX_PERCENTAGE') }} as CC_TAX_PERCENTAGE
from {{ source('src', 'call_center_test') }}