local map = require "mappings.SIUS12"
-- local IsFiltered = require "filter"

local function ExtractSurgeryInfo(Data)
   local Out = {}
   
   Out.MRN = Data.PATIENT_SIUS27[1].PID[2]
	Out.PatientName = Data.PATIENT_SIUS27[1].PID[5][1]
   Out.Duration = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[11]
   Out.DurationUnits = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[12]
	Out.StartDateTime = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[8]
   Out.OrId = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[3][1]
   Out.OrName = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[3][2]
   
   return Out
end

function main(Data)
   Data = hl7.parse{data=Data,vmd='siu.vmd'}
   local Result = ExtractSurgeryInfo(Data)

	local JS = json.serialize{data=Result}

   queue.push{data=JS}
end 