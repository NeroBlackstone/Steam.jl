using Test
using SteamWebAPIs
using URIs,HTTP,Serde,JSON,Dates

init_key()

include("apikey.jl")
include("ISteamNews.jl")
include("ISteamUserStats.jl")
include("ISteamUser.jl")
include("Locations.jl")
include("IPlayerService.jl")