module SteamWebAPIs

using URIs,HTTP,Dates,JSON,Serde

include("utils.jl")
include("api/ISteamNews.jl")
include("api/ISteamUser.jl")
include("api/locations.jl")
include("api/ISteamUserStats.jl")
include("deser.jl")

export init_key
export get_news_for_app
export get_global_achievement_percentages_for_app
export get_player_summaries
export get_countries
export get_states
export get_cities
export get_friend_list
export get_player_achievements
export get_user_stats_for_game

end # module SteamWebAPIs
