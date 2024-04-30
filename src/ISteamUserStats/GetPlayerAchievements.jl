const PATH_player_achievements = "/ISteamUserStats/GetPlayerAchievements/v0001/"

"""
    struct Achievement
        apiname::String
        achieved::Bool
        unlocktime::Int
        name::Union{String,Nothing}
        description::Union{String,Nothing}
    end

Achievement item.

# Fields:
- `apiname`: The API name of the achievement.
- `achieved`: Whether or not the achievement has been completed.
- `unlocktime`: Date when the achievement was unlocked.
- `name`: Localized achievement name.
- `description`: Localized description of the achievement.
"""
struct Achievement
    apiname::String
    achieved::Bool
    unlocktime::Int
    name::Union{String,Nothing}
    description::Union{String,Nothing}
end

"""
    struct PlayerAchievements
        gameName::String
        achievements::Vector{Achievement}
    end

Return type of [`get_player_achievements`](@ref).

# Fields:
- `gameName`: Name of the game.
- `achievements`: Vector of [`Achievement`](@ref).
"""
struct PlayerAchievements
    gameName::String
    achievements::Vector{Achievement}
end

"""
    get_player_achievements(steamid::Int,appid::Int;l::String)::PlayerAchievements

**Summary**: `get_player_achievements` returns a list of achievements for this user by app id.

# Arguments
- `steamid`: 64 bit Steam ID to return friend list for.
- `appid`: The ID for the game you're requesting.
- `l`: Language. If specified, it will return language data for the requested language.

# Example
```julia-repl
julia> dump(get_player_achievements(76561198309475951,553850;l="japanese"))
SteamWebAPIs.PlayerAchievements
  gameName: String "HELLDIVERS™ 2"
  achievements: Array{SteamWebAPIs.Achievement}((38,))
    1: SteamWebAPIs.Achievement
      apiname: String "1"
      achieved: Bool false
      unlocktime: Int64 0
      name: String "ヘルダイブ"
      description: String "難易度がエクストリーム以上のミッションを、誰も死ぬことなく完了する"
    2: SteamWebAPIs.Achievement
      apiname: String "2"
      achieved: Bool false
      unlocktime: Int64 0
      name: String "武器はいらない"
      description: String "難易度がハード以上のミッションを、誰一人メインウェポンまたは支援武器を発砲せずに完了する"
    ...
    37: SteamWebAPIs.Achievement
      apiname: String "37"
      achieved: Bool true
      unlocktime: Int64 1710519126
      name: String "夜になると現れる"
      description: String "夜間にミッションから離脱する"
    38: SteamWebAPIs.Achievement
      apiname: String "38"
      achieved: Bool true
      unlocktime: Int64 1710565961
      name: String "管理民主主義を広めよ"
      description: String "１つのミッション中に敵を150体倒す"
```
"""
function get_player_achievements(steamid::Int,appid::Int;l::String)::PlayerAchievements
    is_above_zero(steamid,appid)
    r=HTTP.get(query_url(PATH_player_achievements;query=query_dict(;SteamWebAPIs.key,steamid,appid,l)))
    return deser_json(PlayerAchievements,JSON.json(first(values(JSON.parse(String(r.body))))))
end