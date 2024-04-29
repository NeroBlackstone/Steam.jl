const PATH_Get_Countries = "/actions/QueryLocations/"

struct Country
    countrycode::String
    hasstates::Int
    countryname::String
end

"""
    get_countries()::Dict{String,Tuple{Bool,String}}

**Summary**: `get_countries` returns a Dict of Countries,key is country code, value is a Tuple, the first element of Tuple indicates whether there has stete, the second is countryname.

# Example
```julia-repl
julia> get_countries()
countries = Dict("ES" => (1, "Spain")......"SM" => (1, "San Marino"))
```
"""
function get_countries()::Dict{String,Tuple{Bool,String}}
    countries = deser_json(Vector{Country},String(HTTP.get(query_url(PATH_Get_Countries;host="steamcommunity.com")).body))
    return Dict(c.countrycode=>(c.hasstates == 1,c.countryname) for c in countries) 
end

struct State
    statecode::String
    statename::String
end

"""
    get_states(countrycode::String)::Dict{String,String}

**Summary**: `get_states` returns a Dict of States by countrycode, key is state code, value is state name.

# Arguments
- `countrycode`: Country code to be queried.

# Example
```julia-repl
julia> get_states("CN")
Dict("24" => "Shanxi", "29" => "Yunnan", "32" => "Sichuan", "07" => "Fujian", "12" => "Hubei", "20" => "Nei Mongol", "06" => "Qinghai", "25" => "Shandong", "03" => "Jiangxi", "22" => "Beijing", "11" => "Hunan", "23" => "Shanghai", "13" => "Xinjiang", "15" => "Gansu", "04" => "Jiangsu", "31" => "Hainan", "33" => "Chongqing", "28" => "Tianjin", "16" => "Guangxi", "14" => "Xizang", "21" => "Ningxia", "09" => "Henan", "05" => "Jilin", "01" => "Anhui", "08" => "Heilongjiang", "26" => "Shaanxi", "10" => "Hebei", "19" => "Liaoning", "18" => "Guizhou", "02" => "Zhejiang", "30" => "Guangdong")
```
"""
function get_states(countrycode::String)::Dict{String,String}
    r = HTTP.get(query_url("$(PATH_Get_Countries)$(countrycode)";host="steamcommunity.com"))
    return Dict(s.statecode=>s.statename for s in deser_json(Vector{State},String(r.body)))
end

struct City
  cityid::Int
  cityname::String
end

"""
	get_cities(countrycode::String,statecode::String)::Dict{Int,String}

**Summary**: `get_cities` returns a Dict of Cities by countrycode and statecode, key is city code, value is city name.

# Arguments
- `countrycode`: Country code to be queried.
- `statecode`: State code to be queried.

# Example
```julia-repl
julia> get_cities("CN","01")
cites = Dict(10398 => "Wucheng", 10455 => "Xuanzhou", 9855 => "Bengbu", 10013 => "Hefei", 9830 => "Anqing", 10058 => "Huoqiu", 10035 => "Huainan", 10492 => "Yingshang", 9967 => "Fuyang", 10186 => "Lujiang", 10031 => "Huaibei", 9883 => "Chaohu", 9909 => "Dangtu", 10196 => "Maanshan", 9898 => "Chuzhou", 10347 => "Suzhou", 10375 => "Tongling", 9894 => "Chizhou", 9866 => "Bozhou", 10206 => "Mengcheng", 10363 => "Tangzhai", 10211 => "Mingguang", 10037 => "Huaiyuan", 10401 => "Wuhu", 10083 => "Jieshou", 10184 => "Luan", 10343 => "Suixi", 10381 => "Tunxi")
```
"""
function get_cities(countrycode::String,statecode::String)::Dict{Int,String}
  r = HTTP.get(query_url("$(PATH_Get_Countries)$(countrycode)/$(statecode)";host="steamcommunity.com"))
  return Dict(c.cityid=>c.cityname for c in deser_json(Vector{City},String(r.body)))
end