local template = require "message_template"
-- local map = require "mappings.SIUS12"
-- local IsFiltered = require "filter"

local function ExtractSurgeryInfo(Data)
   local Out = {}
   
   Out.MRN = Data.PATIENT_SIUS27[1].PID[2]:nodeValue()
	Out.PatientName = Data.PATIENT_SIUS27[1].PID[5][1][1][1]:nodeValue()..Data.PATIENT_SIUS27[1].PID[5][1][2]:nodeValue()
   Out.Duration = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[11]:nodeValue()
   Out.DurationUnits = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[12][1]:nodeValue()
	Out.StartDateTime = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[8]:nodeValue()
   Out.OrId = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[3][1]:nodeValue()
   Out.OrName = Data.RESOURCES_SIUS27[1].GENERAL_RESOURCE[1].AIG[3][2]:nodeValue()
   
   return Out
end

function main(Data)
   local Message, Name = hl7.parse{data=Data,vmd='siu.vmd'}
   local Result = ExtractSurgeryInfo(Message)

   if Name == "CATCHALL" then
      return
   end
   
   json.parse{data=template}
   
	local JS = json.serialize{data=Result}

   queue.push{data=JS}
end 