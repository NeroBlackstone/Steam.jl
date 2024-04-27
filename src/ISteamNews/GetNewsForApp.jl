const PATH_news_for_app= "/ISteamNews/GetNewsForApp/v0002/"

"""
    struct NewsItem
        gid::Int
        title::String
        url::String
        is_external_url::Bool
        author::String
        contents::String
        feedlabel::String
        date::Int
        feedname::String
        feed_type::Int
        tags::Union{Vector{String},Nothing}
    end    

Get game news by id.

# Fields:
- `gid`: News ID.
- `title`: News title.
- `url`: News url.
- `is_external_url`: Is this news URL points to a non-Steam site.
- `author`: News author.
- `contents`: News contents, The length is determined by the `maxlength` keywords.
- `feedlabel`: News feedlabel.
- `date`: News publish date (unix time stamp).
- `feedname`: News feedname.
- `feed_type`: News type.
- `tags`: News tags.
"""
struct NewsItem
    gid::Int
    title::String
    url::String
    is_external_url::Bool
    author::String
    contents::String
    feedlabel::String
    date::Int
    feedname::String
    feed_type::Int
    tags::Union{Vector{String},Nothing}
end

"""
    struct Appnews
        appid::Int
        newsitems::Vector{NewsItem}
        count::Int
    end

Return type of [`get_news_for_app`](@ref).

# Fields:
- `appid`: AppID of the game you want the news of.
- `newsitems`: Vector of [`NewsItem`](@ref).
- `count`: Total news count for this game.
"""
struct Appnews
    appid::Int
    newsitems::Vector{NewsItem}
    count::Int
end

"""
    get_news_for_app(appid::Int;
        maxlength::Int=0,
        enddate::DateTime=now(),
        count::Int=20,
        feeds::Vector{String}=String[],
        tages::Vector{String}=String[])::Appnews

**Summary**: `get_news_for_app` returns the latest of a game specified by its AppID.

# Arguments
- `appid`: AppID of the game you want the news of.

# Optional keywords
- `maxlength`: Maximum length of each news entry.
- `enddate`: Retrieve posts earlier than this date (unix epoch timestamp)
- `count`: How many news enties you want to get returned.
- `feeds`: Comma-separated list of feed names to return news for
- `tages`: Comma-separated list of tags to filter by (e.g. 'patchnodes')

# Example
```julia-repl
julia> dump(get_news_for_app(440;maxlength=10,enddate=now(),count=1,feeds=["steam_updates","tf2_blog"]))
    Steam.Appnews
    appid: Int64 440
    newsitems: Array{Steam.NewsItem}((1,))
        1: Steam.NewsItem
        gid: Int64 5762994032406766352
        title: String "Team Fortress 2 Update Released"
        url: String "https://store.steampowered.com/news/220641/"
        is_external_url: Bool false
        author: String "Valve"
        contents: String "An update ..."
        feedlabel: String "Product Update"
        date: Int64 1713822840
        feedname: String "steam_updates"
        feed_type: Int64 0
        tags: Nothing nothing
    count: Int64 1961
```
"""
function get_news_for_app(appid::Int;
    maxlength::Int=0,
    enddate::DateTime=now(),
    count::Int=20,
    feeds::Vector{String}=String[],
    tages::Vector{String}=String[])::Appnews
    is_above_zero(appid,maxlength,count)
    r=HTTP.get(query_url(PATH_news_for_app;query=query_dict(;appid,maxlength,enddate,count,feeds,tages)))
    return deser_json(Appnews,JSON.json(first(values(JSON.parse(String(r.body))))))
end