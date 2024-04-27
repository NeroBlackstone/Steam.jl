push!(LOAD_PATH,"../src/")
using Documenter,Steam

makedocs(sitename="My Documentation")

deploydocs(
    repo="github.com/NeroBlackstone/SteamWebAPIs.jl"
)