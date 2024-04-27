push!(LOAD_PATH,"../src/")
using Documenter,SteamWebAPIs

makedocs(sitename="SteamWebAPIs.jl",
    pages=[
        "Index.md",
        "ISteamNews"=>"ISteamNews.md",
        "ISteamUser"=>"ISteamUser.md",
        "ISteamUserStats"=>"ISteamUserStats.md",
    ]
)

deploydocs(
    repo="github.com/NeroBlackstone/SteamWebAPIs.jl"
)