## SteamWebAPIs.jl

Steam Web API wrapper for Julia

## API Key

Please apply for your [steam api key](https://steamcommunity.com/dev/apikey) first. Then paste your api key at `$HOME/.steam/apikey.txt`. Or save api key to `STEAM_KEY` environment variable.

## Initialization

Before calling any interface that requires an API key, you need to initialize the Steam Web API key with `init_key()`. Otherwise, you can only call interfaces that do not require an API key.

``` julia-repl
julia> init_key()
```

## Implemented functions

- [`get_news_for_app`](@ref)
- [`get_player_summaries`](@ref)
- [`get_global_achievement_percentages_for_app`](@ref)
- [`get_countries`](@ref)
- [`get_states`](@ref)
- [`get_cities`](@ref)
- [`get_friend_list`](@ref)
- [`get_player_achievements`](@ref)
- [`get_user_stats_for_game`](@ref)
- [`get_owned_games`](@ref)
- [`get_recently_played_games`](@ref)
- [`get_number_of_current_players`](@ref)


## Example

Get the number of games you purchased but never played:

```julia-repl
julia> using SteamWebAPIs
julia> init_key()
julia> count(g->g.playtime_forever==0,get_owned_games(76561198202322923).games)
73
```