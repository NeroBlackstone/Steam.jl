const PATH_ISteamUserStates = "/ISteamUserStats"

const PATH_achievement_percentages= "GetGlobalAchievementPercentagesForApp/v0002"
const PATH_player_achievements = "GetPlayerAchievements/v0001"
const PATH_user_stats_for_game = "GetUserStatsForGame/v0002"

"""
    get_global_achievement_percentages_for_app(gameid::Int)::Dict{String,Float16}

**Summary**: `get_global_achievement_percentages_for_app` returns on global achievements overview of a specific game in percentages.

# Arguments
- `gameid`: GameID to retrieve the achievement percentages for.

# Example
```julia-repl
julia> get_global_achievement_percentages_for_app(440)
Dict{String, Float16}("TF_MAPS_DOOMSDAY_PUSH_INTO_EXHAUST" => 7.9...)
```
"""
function get_global_achievement_percentages_for_app(gameid::Int)::Dict{String,Float16}
    is_above_zero(gameid)
    path = joinpath(PATH_ISteamUserStates,PATH_achievement_percentages)
    r=HTTP.get(query_url(path;query=query_dict(;gameid)))
    return Dict(a["name"]=>a["percent"] for a in first(values(first(values(JSON.parse(String(r.body)))))))
end

"""
    struct Achievement
        apiname::String
        achieved::Bool
        unlocktime::Union{DateTime,Nothing}
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
    unlocktime::Union{DateTime,Nothing}
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
      unlocktime: Nothing nothing
      name: String "ヘルダイブ"
      description: String "難易度がエクストリーム以上のミッションを、誰も死ぬことなく完了する"
    2: SteamWebAPIs.Achievement
      apiname: String "2"
      achieved: Bool false
      unlocktime: Nothing nothing
      name: String "武器はいらない"
      description: String "難易度がハード以上のミッションを、誰一人メインウェポンまたは支援武器を発砲せずに完了する"
    ...
    38: SteamWebAPIs.Achievement
      apiname: String "38"
      achieved: Bool true
      unlocktime: DateTime
        instant: Dates.UTInstant{Millisecond}
          periods: Millisecond
            value: Int64 63846249161000
      name: String "管理民主主義を広めよ"
      description: String "１つのミッション中に敵を150体倒す"
```
"""
function get_player_achievements(steamid::Int,appid::Int;l::String)::PlayerAchievements
    is_above_zero(steamid,appid)
    path = joinpath(PATH_ISteamUserStates,PATH_player_achievements)
    r=HTTP.get(query_url(path;query=query_dict(;SteamWebAPIs.key,steamid,appid,l)))
    return deser_json(PlayerAchievements,JSON.json(first(values(JSON.parse(String(r.body))))))
end


"""
    struct PlayerStats
        gameName::String
        achievements::Vector{String}
        stats::Dict{String,Real}
    end

Return type of [`get_user_stats_for_game`](@ref).

# Fields:
- `gameName`: Name of the game.
- `achievements`: Vector of achievements api name, all unlocked by user.
- `stats`: Dict of game stats, key is stats name, value is stats value.
"""
struct PlayerStats
    gameName::String
    achievements::Vector{String}
    stats::Dict{String,Real}
end

"""
    get_user_stats_for_game(steamid::Int,appid::Int)::PlayerStats

**Summary**: `get_user_stats_for_game` Returns a list of achievements and stats for this user by app id.

# Arguments
- `steamid`: 64 bit Steam ID to return friend list for.
- `appid`: The ID for the game you're requesting.

# Example
```julia-repl
julia> get_user_stats_for_game(76561198309475951,1238810)
SteamWebAPIs.PlayerStats("Battlefield ™ V", ["Achievement_GOSCC_1"...], Dict{String, Real}("stat_4" => 1...))
```
"""
function get_user_stats_for_game(steamid::Int,appid::Int)::PlayerStats
    is_above_zero(steamid,appid)
    path = joinpath(PATH_ISteamUserStates,PATH_user_stats_for_game)
    r=HTTP.get(query_url(path;query=query_dict(;SteamWebAPIs.key,steamid,appid)))
    stats_dict = first(values(JSON.parse(String(r.body))))
    achievements = [a["name"] for a in stats_dict["achievements"]]
    stats = Dict(s["name"]=>s["value"] for s in stats_dict["stats"])
    return PlayerStats(stats_dict["gameName"],achievements,stats)
end