local kong = kong
local re = ngx.re

local headers = kong.response.get_headers()
local content_type = headers["Content-Type"]
local supported_content_type = "(html|json|xml|plain|css)"

local function transform_body(body)
	local numeral = { [0] = "๐", "๑", "๒", "๓", "๔", "๕", "๖", "๗", "๘", "๙" }
	for i = 0, #numeral do
		body = body:gsub(numeral[i], i)
	end
	return body
end

if re.match(content_type, supported_content_type) then
	local body = kong.response.get_raw_body()
	if body then
		return kong.response.set_raw_body(transform_body(body))
	end
end
