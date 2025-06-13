
-- Simple CSV line splitter
local function split(str, sep)
  local result = {}
  for token in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(result, token)
  end
  return result
end

function loadCSV(path)
  local file = io.open(path, "r")
  if not file then error("Could not open file: " .. path) end
  
  local data = {}
  local headers = {}
  local i = 0
  for line in file:lines() do
    i = i + 1
    local fields = split(line, ",")
    if i == 1 then
      headers = fields
    else
      local row = {}
      for j, header in ipairs(headers) do
        row[header] = fields[j]
      end
      table.insert(data, row)
    end
  end
  file:close()
  return data
end
