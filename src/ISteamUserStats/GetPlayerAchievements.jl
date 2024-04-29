const PATH_player_achievements = "/ISteamUserStats/GetPlayerAchievements/v0001/"

struct Achievement
    apiname::String
    achieved::Bool
    unlocktime::Int
    name::Union{String,Nothing}
    description::Union{String,Nothing}
end

struct PlayerAchievements
    gameName::String
    achievements::Vector{Achievement}
end

function get_player_achievements(steamid::Int,appid::Int;l::String)::PlayerAchievements
    is_above_zero(steamid,appid)
    r=HTTP.get(query_url(PATH_player_achievements;query=query_dict(;steamid,appid,l)))
    return deser_json(PlayerAchievements,JSON.json(first(values(JSON.parse(String(r.body))))))
end