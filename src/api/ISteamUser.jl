const PATH_ISteamUser = "/ISteamUser"

const PATH_player_summaries = "/GetPlayerSummaries/v2"
const PATH_friend_list = "/GetFriendList/v1"

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
        lastlogoff::Union{DateTime,Nothing}
        personastate::Int
        # Private Data
        primaryclanid::Int
        timecreated::DateTime
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
- `lastlogoff`: The last time the user was online.
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
    lastlogoff::Union{DateTime,Nothing}
    personastate::Int
    # Private Data
    primaryclanid::Int
    timecreated::DateTime
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
    steamid: Int64 76561198309475951
    communityvisibilitystate: Int64 3
    profilestate: Int64 1
    personaname: String "SkyEast"
    profileurl: String "https://steamcommunity.com/id/skyeast/"
    avatar: String "https://avatars.steamstatic.com/de7aed4299406a52b01b0fc087ec5eb1d380b7e7.jpg"
    avatarmedium: String "https://avatars.steamstatic.com/de7aed4299406a52b01b0fc087ec5eb1d380b7e7_medium.jpg"
    avatarfull: String "https://avatars.steamstatic.com/de7aed4299406a52b01b0fc087ec5eb1d380b7e7_full.jpg"
    avatarhash: String "de7aed4299406a52b01b0fc087ec5eb1d380b7e7"
    lastlogoff: DateTime
      instant: Dates.UTInstant{Millisecond}
        periods: Millisecond
          value: Int64 63850008696000
    personastate: Int64 1
    primaryclanid: Int64 103582791455934525
    timecreated: DateTime
      instant: Dates.UTInstant{Millisecond}
        periods: Millisecond
          value: Int64 63601217062000
    personastateflags: Int64 0
    loccountrycode: String "CN"
    locstatecode: Nothing nothing
    loccityid: Nothing nothing
    realname: String "E-Ject"
    gameextrainfo: String "HELLDIVERS™ 2"
    gameid: Int64 553850
```
"""
function get_player_summaries(steamids::Vector{Int})::Vector{Player}
    is_above_zero(steamids...)
    path = PATH_ISteamUser*PATH_player_summaries
    r=HTTP.get(query_url(path;query=query_dict(;SteamWebAPIs.key,steamids)))
    return deser_json(Vector{Player},JSON.json(first(values(first(values(JSON.parse(String(r.body))))))))
end

"""
    get_friend_list(steamid::Int)::Dict{Int,DateTime}

**Summary**: `get_friend_list` returns the friend Dict of any Steam user, provided their Steam Community profile visibility is set to "Public". Nothing will be returned if the profile is private. Key of Dict is steamid, value is the date on which we became friends.

# Arguments
- `steamid`: 64 bit Steam ID to return friend list for.

# Example
```julia-repl
julia> get_friend_list(76561198202322924)
friends = Dict(76561198347283942 => Dates.DateTime("2021-12-24T06:08:57")...)
```
"""
function get_friend_list(steamid::Int)::Dict{Int,DateTime}
    is_above_zero(steamid)
    path = PATH_ISteamUser*PATH_friend_list
    r=HTTP.get(query_url(path;query=query_dict(;SteamWebAPIs.key,steamid)))
    friends = first(values(first(values(JSON.parse(String(r.body))))))
    return Dict(parse(Int,f["steamid"])=>unix2datetime(f["friend_since"]) for f in friends)
end