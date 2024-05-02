const PATH_IPlayerService = "/IPlayerService"

const PATH_owned_games = "/GetOwnedGames/v1"
const PATH_recently_played_games = "/GetRecentlyPlayedGames/v1"

"""
    struct Game
        appid::Int
        playtime_forever::Int
        playtime_windows_forever::Int
        playtime_mac_forever::Int
        playtime_linux_forever::Int
        playtime_deck_forever::Int
        rtime_last_played::Union{DateTime,Nothing}
        playtime_disconnected::Int
        # include_appinfo:
        name::Union{String,Nothing}
        img_icon_url::Union{String,Nothing}
        has_leaderboards::Union{Bool,Nothing}
        has_community_visible_stats::Union{Bool,Nothing}
        content_descriptorids::Union{Vector{Int},Nothing}
    end

Owned game information. 

# Fields:
- `appid`: Unique identifier for the game.
- `playtime_forever`: The total number of minutes played "on record", since Steam began tracking total playtime in early 2009.
- `playtime_windows_forever`: The total number of minutes played on Windows.
- `playtime_mac_forever`: The total number of minutes played on Mac.
- `playtime_linux_forever`: The total number of minutes played on Linux.
- `playtime_deck_forever`: The total number of minutes played on Steam Deck.
- `rtime_last_played`: Recent play time.
- `playtime_disconnected`: The total number of minutes played offline.
- `name`: The name of the game.
- `img_icon_url`: These are the filenames of various images for the game. To construct the URL to the image, use this format: http://media.steampowered.com/steamcommunity/public/images/apps/{appid}/{hash}.jpg. For example, the TF2 logo is returned as "07385eb55b5ba974aebbe74d3c99626bda7920b8", which maps to the [URL](http://media.steampowered.com/steamcommunity/public/images/apps/440/07385eb55b5ba974aebbe74d3c99626bda7920b8.jpg).
- `has_leaderboards`: Does this game have a leaderboard.
- `has_community_visible_stats`: Indicates there is a stats page with achievements or other game stats available for this game. The uniform URL for accessing this data is http://steamcommunity.com/profiles/{steamid}/stats/{appid}.
- `content_descriptorids`: Unknow.
"""
struct Game
    appid::Int
    playtime_forever::Int
    playtime_windows_forever::Int
    playtime_mac_forever::Int
    playtime_linux_forever::Int
    playtime_deck_forever::Int
    rtime_last_played::Union{DateTime,Nothing}
    playtime_disconnected::Int
    name::Union{String,Nothing}
    img_icon_url::Union{String,Nothing}
    has_leaderboards::Union{Bool,Nothing}
    has_community_visible_stats::Union{Bool,Nothing}
    content_descriptorids::Union{Vector{Int},Nothing}
end

"""
    struct OwnedGames
        game_count::Int
        games::Vector{Game}
    end

Return type of [`get_owned_games`](@ref).

# Fields:
- `game_count`: The total number of games the user owns (including free games they've played, if include_played_free_games was passed).
- `games`: A [`Game`]@ref Vector. 
"""
struct OwnedGames
    game_count::Int
    games::Vector{Game}
end

"""
    get_owned_games(steamid::Int;
        include_appinfo::Bool=false,
        include_played_free_games::Bool=false)::OwnedGames

**Summary**: `get_owned_games` returns a list of games a player owns along with some playtime information, if the profile is publicly visible. Private, friends-only, and other privacy settings are not supported unless you are asking for your own personal details (ie the WebAPI key you are using is linked to the steamid you are requesting).

# Arguments
- `steamid`: The SteamID of the account.

# Optional keywords
- `include_appinfo`: Include game name and logo information in the output. The default is to return appids only.
- `include_played_free_games`: By default, free games like Team Fortress 2 are excluded (as technically everyone owns them). If include_played_free_games is set, they will be returned if the player has played them at some point. This is the same behavior as the games list on the Steam Community.

# Example
```julia-repl
julia> dump(recent_games = get_recently_played_games(76561198202322923,count=1))
SteamWebAPIs.RecentGames
  total_count: Int64 5
  games: Array{SteamWebAPIs.RecentGame}((1,))
    1: SteamWebAPIs.RecentGame
      appid: Int64 359550
      name: String "Tom Clancy's Rainbow Six Siege"
      playtime_2weeks: Int64 811
      playtime_forever: Int64 60942
      img_icon_url: String "624745d333ac54aedb1ee911013e2edb7722550e"
```
"""
function get_owned_games(steamid::Int;
    include_appinfo::Bool=false,
    include_played_free_games::Bool=false)::OwnedGames
    is_above_zero(steamid)
    path = PATH_IPlayerService*PATH_owned_games
    r=HTTP.get(query_url(path;query=query_dict(;SteamWebAPIs.key,steamid,include_appinfo,include_played_free_games)))
    return deser_json(OwnedGames,JSON.json(first(values(JSON.parse(String(r.body))))))
end

"""
    struct RecentGame
        appid::Int
        name::String
        playtime_2weeks::Int
        playtime_forever::Int
        img_icon_url::String
    end

Recently played game information. 

# Fields:
- `appid`: Unique identifier for the game.
- `name`: The name of the game.
- `playtime_2weeks`: The total number of minutes played in the last 2 weeks.
- `playtime_forever`: The total number of minutes played "on record", since Steam began tracking total playtime in early 2009.
- `img_icon_url`: - `img_icon_url`: These are the filenames of various images for the game. To construct the URL to the image, use this format: http://media.steampowered.com/steamcommunity/public/images/apps/{appid}/{hash}.jpg. For example, the TF2 logo is returned as "07385eb55b5ba974aebbe74d3c99626bda7920b8", which maps to the [URL](http://media.steampowered.com/steamcommunity/public/images/apps/440/07385eb55b5ba974aebbe74d3c99626bda7920b8.jpg).
"""
struct RecentGame
    appid::Int
    name::String
    playtime_2weeks::Int
    playtime_forever::Int
    img_icon_url::String
end

"""
    struct RecentGames
        total_count::Int
        games::Vector{RecentGame}
    end

Return type of [`get_recently_played_games`](@ref).

# Fields:
- `total_count`: The total number of unique games the user has played in the last two weeks. This is mostly significant if you opted to return a limited number of games with the count input parameter.
- `games`: A [`RecentGame`]@ref Vector. 
"""
struct RecentGames
    total_count::Int
    games::Union{Nothing,Vector{RecentGame}}
end


"""
    get_recently_played_games(steamid::Int;count=1)::RecentGames

**Summary**: `get_recently_played_games` returns a list of games a player has played in the last two weeks, if the profile is publicly visible. Private, friends-only, and other privacy settings are not supported unless you are asking for your own personal details (ie the WebAPI key you are using is linked to the steamid you are requesting).

# Arguments
- `steamid`: The SteamID of the account.

# Optional keywords
- `count`: Optionally limit to a certain number of games (the number of games a person has played in the last 2 weeks is typically very small)

# Example
```julia-repl
julia> dump(get_recently_played_games(76561198309475951,count=1))
SteamWebAPIs.RecentGames
  total_count: Int64 5
  games: Array{SteamWebAPIs.RecentGame}((1,))
    1: SteamWebAPIs.RecentGame
      appid: Int64 359550
      name: String "Tom Clancy's Rainbow Six Siege"
      playtime_2weeks: Int64 811
      playtime_forever: Int64 60942
      img_icon_url: String "624745d333ac54aedb1ee911013e2edb7722550e"
```
"""
function get_recently_played_games(steamid::Int;count=1)::RecentGames
    is_above_zero(steamid,count)
    path = PATH_IPlayerService*PATH_recently_played_games
    r=HTTP.get(query_url(path;query=query_dict(;SteamWebAPIs.key,steamid,count)))
    return deser_json(RecentGames,JSON.json(first(values(JSON.parse(String(r.body))))))
end