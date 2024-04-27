push!(LOAD_PATH,"../src/")
using Documenter,SteamWebAPIs

makedocs(sitename="SteamWebAPIs.jl",
    pages=[
        "ISteamNews"=>"ISteamNews.md",
        "ISteamUser"=>"ISteamUser.md",
        "ISteamUserStats"=>"ISteamUserStats.md",
    ]
)

deploydocs(
    repo="github.com/NeroBlackstone/SteamWebAPIs.jl"
)