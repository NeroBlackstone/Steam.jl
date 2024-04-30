const PATH_Get_Countries = "/actions/QueryLocations/"

"""
    get_countries()::Dict{String,Tuple{Bool,String}}

**Summary**: `get_countries` returns a Dict of Countries,key is country code, value is a Tuple, the first element of Tuple indicates whether there has stete, the second is countryname.

# Example
```julia-repl
julia> get_countries()
countries = Dict("ES" => (1, "Spain")...)
```
"""
function get_countries()::Dict{String,Tuple{Bool,String}}
    countries = JSON.parse(String(HTTP.get(query_url(PATH_Get_Countries;host="steamcommunity.com")).body))
    return Dict(c["countrycode"]=>(c["hasstates"] == 1,c["countryname"]) for c in countries)
end

"""
    get_states(countrycode::String)::Dict{String,String}

**Summary**: `get_states` returns a Dict of States by countrycode, key is state code, value is state name.

# Arguments
- `countrycode`: Country code to be queried.

# Example
```julia-repl
julia> get_states("CN")
Dict("24" => "Shanxi"...)
```
"""
function get_states(countrycode::String)::Dict{String,String}
    r = HTTP.get(query_url("$(PATH_Get_Countries)$(countrycode)";host="steamcommunity.com"))
    return Dict(s["statecode"]=>s["statename"] for s in JSON.parse(String(r.body)))
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
cites = Dict(10398 => "Wucheng"...)
```
"""
function get_cities(countrycode::String,statecode::String)::Dict{Int,String}
    r = HTTP.get(query_url("$(PATH_Get_Countries)$(countrycode)/$(statecode)";host="steamcommunity.com"))
    return Dict(c["cityid"]=>c["cityname"] for c in JSON.parse(String(r.body)))
end