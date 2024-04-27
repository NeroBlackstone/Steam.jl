const PATH_player_summaries = "/ISteamUser/GetPlayerSummaries/v0002/"

"""
    struct Player
        # Public Data
        steamid::Int
        communityvisibilitystate::Int
        profilestate::Int
        personaname::String
        profileurl::String
        avatar::String
        avatarmedium::String
        avatarfull::String
        avatarhash::String
        lastlogoff::Union{Int,Nothing}
        personastate::Int
        # Private Data
        primaryclanid::Int
        timecreated::Int
        personastateflags::Int
        loccountrycode::Union{String,Nothing}
        locstatecode::Union{Int,Nothing}
        loccityid::Union{Int,Nothing}
        realname::Union{String,Nothing}
        gameextrainfo::Union{String,Nothing}
        gameid::Union{Int,Nothing}
    end

Return type of [`get_player_summaries`](@ref).

# Fields:
- `steamid`: 64bit SteamID of the user.
- `communityvisibilitystate`: This represents whether the profile is visible or not, and if it is visible, why you are allowed to see it. Note that because this WebAPI does not use authentication, there are only two possible values returned: 1 - the profile is not visible to you (Private, Friends Only, etc), 3 - the profile is "Public", and the data is visible.
- `profilestate`: If set, indicates the user has a community profile configured (will be set to '1')
- `personaname`: The player's persona name (display name)
- `profileurl`: The full URL of the player's Steam Community profile.
- `avatar`: The full URL of the player's 32x32px avatar. If the user hasn't configured an avatar, this will be the default ? avatar.
- `avatarmedium`: The full URL of the player's 64x64px avatar. If the user hasn't configured an avatar, this will be the default ? avatar.
- `avatarfull`: The full URL of the player's 184x184px avatar. If the user hasn't configured an avatar, this will be the default ? avatar.
- `avatarhash`: Unknow.
- `lastlogoff`: The last time the user was online, in unix time.
- `personastate`: The user's current status. 0 - Offline, 1 - Online, 2 - Busy, 3 - Away, 4 - Snooze, 5 - looking to trade, 6 - looking to play. If the player's profile is private, this will always be "0", except is the user has set their status to looking to trade or looking to play, because a bug makes those status appear even if the profile is private.
- `primaryclanid`: The player's primary group, as configured in their Steam Community profile.
- `timecreated`: The time the player's account was created.
- `personastateflags`: Unknow.
- `loccountrycode`: If set on the user's Steam Community profile, The user's country of residence, 2-character ISO country code
- `locstatecode`: If set on the user's Steam Community profile, The user's state of residence.
- `loccityid`: An internal code indicating the user's city of residence. A future update will provide this data in a more useful way.
- `realname`: The player's "Real Name", if they have set it.
- `gameextrainfo`: If the user is currently in-game, this will be the name of the game they are playing. This may be the name of a non-Steam game shortcut.
- `gameid`: If the user is currently in-game, this value will be returned and set to the gameid of that game.
"""
struct Player
    # Public Data
    steamid::Int
    communityvisibilitystate::Int
    profilestate::Int
    personaname::String
    profileurl::String
    avatar::String
    avatarmedium::String
    avatarfull::String
    avatarhash::String
    lastlogoff::Union{Int,Nothing}
    personastate::Int
    # Private Data
    primaryclanid::Int
    timecreated::Int
    personastateflags::Int
    loccountrycode::Union{String,Nothing}
    locstatecode::Union{String,Nothing}
    loccityid::Union{Int,Nothing}
    realname::Union{String,Nothing}
    gameextrainfo::Union{String,Nothing}
    gameid::Union{Int,Nothing}
end

"""
    get_player_summaries(steamids::Vector{Int})::Vector{Player}

**Summary**: `get_player_summaries` returns basic profile information for a list of 64-bit Steam IDs.

# Arguments
- `steamids`: Vector of 64 bit Steam IDs to return profile information for. Up to 100 Steam IDs can be requested.

# Example
```julia-repl
julia> dump(get_player_summaries([76561198202322924]))
Array{SteamWebAPIs.Player}((1,))
  1: SteamWebAPIs.Player
    steamid: Int64 76561198202322924
    communityvisibilitystate: Int64 3
    profilestate: Int64 1
    personaname: String "archlinux"
    profileurl: String "https://steamcommunity.com/id/NeroBlackstone/"
    avatar: String "https://avatars.steamstatic.com/8968076741d594170face46a70c7d0bb92c14f69.jpg"
    avatarmedium: String "https://avatars.steamstatic.com/8968076741d594170face46a70c7d0bb92c14f69_medium.jpg"
    avatarfull: String "https://avatars.steamstatic.com/8968076741d594170face46a70c7d0bb92c14f69_full.jpg"
    avatarhash: String "8968076741d594170face46a70c7d0bb92c14f69"
    lastlogoff: Int64 1713382544
    personastate: Int64 0
    primaryclanid: Int64 103582791429521408
    timecreated: Int64 1434629419
    personastateflags: Int64 0
    loccountrycode: String "CN"
    locstatecode: String "03"
    loccityid: Int64 10221
    realname: Nothing nothing
    gameextrainfo: Nothing nothing
    gameid: Nothing nothing
```
"""
function get_player_summaries(steamids::Vector{Int})::Vector{Player}
    is_above_zero(steamids...)
    r=HTTP.get(query_url(PATH_player_summaries;query=query_dict(;SteamWebAPIs.key,steamids)))
    return deser_json(Vector{Player},JSON.json(first(values(first(values(JSON.parse(String(r.body))))))))
end