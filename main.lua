-- Fetch data
local _response = fetch({
    url = "https://api.buss.lol/domains",
    method = "GET",
    headers = { },
    body = ""
});
local response = {};

---checks if a string represents an ip address
-- @return true or false
function isIpAddress(ip)
    if not ip then return false end
    local a,b,c,d=ip:match("^(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)$")
    a=tonumber(a)
    b=tonumber(b)
    c=tonumber(c)
    d=tonumber(d)
    if not a or not b or not c or not d then return false end
    if a<0 or 255<a then return false end
    if b<0 or 255<b then return false end
    if c<0 or 255<c then return false end
    if d<0 or 255<d then return false end
    return true
end

-- Filter the list for 'IPs' that start with banned phrases. We want to weed out the majority
-- of invalid 'IPs'.
for index, item in pairs(_response) do
    local ip = item["ip"];
    local name = item["name"];

    if isIpAddress(ip) or ip == 'https://minidogg.github.io/catlol/' then
        table.insert(response, item);
    end
end

get("botted").set_content(#response .. "");
get("not-botted").set_content(#_response .. "");
