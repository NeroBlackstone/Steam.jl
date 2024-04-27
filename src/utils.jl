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
query_string(v::Union{Vector{String},Vector{<:Number}})=join(v,',')