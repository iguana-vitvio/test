local map = require "mappings.SIUS12"
-- local IsFiltered = require "filter"

local function ExtractSurgeryInfo(Data)
   local Out = {}
   
	Out.PatientName = Data.PATIENT_SIUS27[1].PID[5][1]
   
   return Out
end

-- function main(Data)
-- 	--trace('hello')
--       -- _G to see available func
-- 	local InboundMsg, MsgType =    hl7.parse{data=Data,vmd='siu.vmd'}
--    trace(Data, MsgType)

   
   
   
--    queue.push{data=Data}
-- end
function main(Data)
   Data = hl7.parse{data=Data,vmd='siu.vmd'}
   local Result = ExtractSurgeryInfo(Data)
   trace(Result)
   -- Create a JSON formatted output

--    local Output = {
--       scheduledSurgery = Result.ScheduledSurgery,
--       startTime = Result.StartTime,
--       endTime = Result.EndTime,
--       duration = Result.Duration .. " " .. Result.DurationUnits,
--       surgeonsBlock = Result.SurgeonsBlock,
--       practitioner = Result.Practitioner,
--       patientName = Result.PatientName,
--       mrn = Result.MRN
--    }
   
	local JS = json.serialize{data=Result}
   trace(Result)

   return JS
end 