const PATH_friend_list = "/ISteamUser/GetFriendList/v0001/"

"""
    struct Friend
        steamid::String
        friend_since::Int
    end

Return type of [`get_friend_list`](@ref).

# Fields:
- `steamid`: 64bit SteamID of the friend.
- `friend_since`: Unix timestamp of the time when the relationship was created.

"""
struct Friend
    steamid::String
    friend_since::Int
end

"""
    get_friend_list(steamid::Int)::Vector{Friend}

**Summary**: `get_friend_list` returns the friend list of any Steam user, provided their Steam Community profile visibility is set to "Public". Nothing will be returned if the profile is private.

# Arguments
- `steamid`: 64 bit Steam ID to return friend list for.

# Example
```julia-repl
julia> get_friend_list(76561198202322924)
Array{SteamWebAPIs.Friend}((1792,))
  1: SteamWebAPIs.Friend
    steamid: String "76561197960270682"
    friend_since: Int64 1647624586
  2: SteamWebAPIs.Friend
    steamid: String "76561197960279742"
    friend_since: Int64 1710223571
  ...
  1791: SteamWebAPIs.Friend
    steamid: String "76561199654378722"
    friend_since: Int64 1713115188
  1792: SteamWebAPIs.Friend
    steamid: String "76561199664162819"
    friend_since: Int64 1713456325
```
"""
function get_friend_list(steamid::Int)::Vector{Friend}
    is_above_zero(steamid)
    r=HTTP.get(query_url(PATH_friend_list;query=query_dict(;SteamWebAPIs.key,steamid)))
    return deser_json(Vector{Friend},JSON.json(first(values(first(values(JSON.parse(String(r.body))))))))
end