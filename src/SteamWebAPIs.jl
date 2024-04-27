module SteamWebAPIs

using URIs,HTTP,Dates,JSON,Serde

include("utils.jl")
include("ISteamNews/GetNewsForApp.jl")
include("ISteamUserStats/GetGlobalAchievementPercentagesForApp.jl")
include("ISteamUser/GetPlayerSummaries.jl")

export init_key
export get_news_for_app
export get_global_achievement_percentages_for_app
export get_player_summaries

end # module SteamWebAPIs
