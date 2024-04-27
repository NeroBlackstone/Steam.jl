module SteamWebAPIs

using URIs,HTTP,Dates,JSON,Serde

include("utils.jl")
include("ISteamNews/GetNewsForApp.jl")

export parse_api_key
export get_news_for_app


end # module Steam
