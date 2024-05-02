push!(LOAD_PATH,"../src/")
using Documenter,SteamWebAPIs

makedocs(sitename="SteamWebAPIs.jl",
    pages=[
        "index.md",
        "ISteamNews"=>"ISteamNews.md",
        "ISteamUser"=>"ISteamUser.md",
        "ISteamUserStats"=>"ISteamUserStats.md",
        "IPlayerService"=>"IPlayerService.md",
        "QueryLocations"=>"QueryLocations.md"
    ]
)

deploydocs(
    repo="github.com/NeroBlackstone/SteamWebAPIs.jl"
)