function init_key()
    global key = try ENV["STEAM_KEY"] catch end
    if isnothing(key)
        try
            global key = open(joinpath("$(homedir())",".steam","apikey.txt")) do f 
                readline(f) 
            end
        catch
            throw("Can't find API key.")
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

query_url(path::String;query::Dict=Dict{}(),host::String="api.steampowered.com") = 
    URI(;scheme="http",host=host,path=path,query=query)

query_dict(;args...)::Dict = filter(p->length(p[2])>0,Dict(("$(a[1])"=>query_string(a[2])) for a in args))

query_string(v::Union{Number,String})=v
query_string(v::DateTime)=floor(Int,datetime2unix(v))
query_string(v::Union{Vector{String},Vector{<:Number}})=join(v,',')

