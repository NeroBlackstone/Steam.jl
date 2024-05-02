function Serde.deser(::Type{T},::Type{E},x::Int)::E where {T<:Union{NewsItem,Player},E<:DateTime}
    return unix2datetime(x) 
end
function Serde.deser(::Type{T},::Type{E},x::Int)::E where {T<:Union{Achievement,Game},E<:Union{DateTime,Nothing}}
    return x==0 ? nothing : unix2datetime(x) 
end