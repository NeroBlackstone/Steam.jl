"""
    parse_api_key()
    parse_api_key(api_key::String="")

Initialize and verify the Steam Web API key.

If `api_key` is unspecified, Steam Web API key is read from `\$HOME/.steam/apikey.txt`.
"""
function parse_api_key(api_key::String="")::String
    key =  if length(api_key)!=0
        api_key
    else
        open(joinpath("$(homedir())",".steam","apikey.txt")) do f 
            readline(f) 
        end
    end
    
    if length(key) != 32
        throw("Invalid Steam web API key.")
    end
    
    try
        parse(Int128,key;base=16)
    catch
        throw("Invalid Steam web API key.")
    end
    return key
end

"""
Check Int arguments.
"""
function is_above_zero(args...)
    for a in args
        if a < 0
            throw(DomainError(a,"need to be greater or equal to 0"))
        end
    end
end

query_url(path::String;query::Dict) = URI(;scheme="http",host="api.steampowered.com",path=path,query=query)

query_dict(;args...)::Dict = filter(p->length(p[2])>0,Dict(("$(a[1])"=>query_string(a[2])) for a in args))

query_string(v::Union{Number,String})=v
query_string(v::DateTime)=floor(Int,datetime2unix(v))
query_string(v::Vector{String})=join(v,',')