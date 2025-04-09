local filters = {}

function filters.messageType(msg)
 
end

function filters.noBobs(msg)
end

local function IsFiltered(msg)
   local isFiltered = false
   for key, value in pairs(filters) do
	  trace(key, value)
      if value(msg) then
         return true
      end
   end

   return isFiltered
end

return IsFiltered