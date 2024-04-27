module SteamWebAPIs

using URIs,HTTP,Dates,JSON,Serde

include("utils.jl")
include("ISteamNews/GetNewsForApp.jl")
include("ISteamUserStats/GetGlobalAchievementPercentagesForApp.jl")
include("ISteamUser/GetPlayerSummaries.jl")

function __init__()
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

export parse_api_key
export get_news_for_app
export get_global_achievement_percentages_for_app
export get_player_summaries

end # module SteamWebAPIs
