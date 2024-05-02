const PATH_IPlayerService = "/IPlayerService"

const PATH_owned_games = "/GetOwnedGames/v0001"

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

**Summary**: `get_owned_games` returns returns a list of games a player owns along with some playtime information, if the profile is publicly visible. Private, friends-only, and other privacy settings are not supported unless you are asking for your own personal details (ie the WebAPI key you are using is linked to the steamid you are requesting).

# Arguments
- `steamid`: The SteamID of the account.

# Optional keywords
- `include_appinfo`: Include game name and logo information in the output. The default is to return appids only.
- `include_played_free_games`: By default, free games like Team Fortress 2 are excluded (as technically everyone owns them). If include_played_free_games is set, they will be returned if the player has played them at some point. This is the same behavior as the games list on the Steam Community.

# Example
```julia-repl
julia> dump(get_owned_games(76561198202322923;include_appinfo=true,include_played_free_games=true))
SteamWebAPIs.OwnedGames
  game_count: Int64 1
  games: Array{SteamWebAPIs.Game}((1,))
    1: SteamWebAPIs.Game
    SteamWebAPIs.Game
        appid: Int64 440
        playtime_forever: Int64 23
        playtime_windows_forever: Int64 0
        playtime_mac_forever: Int64 0
        playtime_linux_forever: Int64 0
        playtime_deck_forever: Int64 0
        rtime_last_played: DateTime
        instant: Dates.UTInstant{Millisecond}
            periods: Millisecond
            value: Int64 63626203907000
        playtime_disconnected: Int64 0
        name: String "Team Fortress 2"
        img_icon_url: String "e3f595a92552da3d664ad00277fad2107345f743"
        has_leaderboards: Bool true
        has_community_visible_stats: Bool true
        content_descriptorids: Array{Int64}((2,)) [2, 5]
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