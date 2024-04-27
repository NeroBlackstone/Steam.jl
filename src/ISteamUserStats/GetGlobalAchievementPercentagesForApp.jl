const PATH_achievement_percentages= "/ISteamUserStats/GetGlobalAchievementPercentagesForApp/v0002/"

"""
    struct AchievementPercentage
        name::String
        percent::Float16
    end

Return type of [`get_global_achievement_percentages_for_app`](@ref).

# Fields:
- `name`: Name of the achievement you want the game of.
- `percent`: Achievement achieved percentage.
"""
struct AchievementPercentage
    name::String
    percent::Float16
end

"""
    get_global_achievement_percentages_for_app(gameid::Int)::Vector{Achievement}

**Summary**: `get_global_achievement_percentages_for_app` returns on global achievements overview of a specific game in percentages.

# Arguments
- `gameid`: GameID to retrieve the achievement percentages for.

# Example
```julia-repl
julia> dump(get_global_achievement_percentages_for_app(440))
Array{SteamWebAPIs.AchievementPercentage}((520,))
  1: SteamWebAPIs.Achievement
    name: String "TF_SCOUT_LONG_DISTANCE_RUNNER"
    percent: Float16 Float16(51.4)
  2: SteamWebAPIs.Achievement
    name: String "TF_HEAVY_DAMAGE_TAKEN"
    percent: Float16 Float16(41.7)
  ...
  519: SteamWebAPIs.Achievement
    name: String "TF_PASS_TIME_HAT"
    percent: Float16 Float16(3.7)
  520: SteamWebAPIs.Achievement
    name: String "TF_PASS_TIME_GRIND"
    percent: Float16 Float16(3.0)
```
"""
function get_global_achievement_percentages_for_app(gameid::Int)::Vector{AchievementPercentage}
    is_above_zero(gameid)
    r=HTTP.get(query_url(PATH_achievement_percentages;query=query_dict(;gameid)))
    return deser_json(Vector{AchievementPercentage},JSON.json(first(values(first(values(JSON.parse(String(r.body))))))))
end