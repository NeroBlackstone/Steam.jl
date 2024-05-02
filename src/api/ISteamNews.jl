const PATH_news_for_app= "/ISteamNews/GetNewsForApp/v2/"

"""
    struct NewsItem
        gid::Int
        title::String
        url::String
        is_external_url::Bool
        author::String
        contents::String
        feedlabel::String
        date::DateTime
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
- `date`: News publish date.
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
    date::DateTime
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
SteamWebAPIs.Appnews
  appid: Int64 440
  newsitems: Array{SteamWebAPIs.NewsItem}((1,))
    1: SteamWebAPIs.NewsItem
      gid: Int64 5759616966668990190
      title: String "Fireside Cup"
      url: String "https://steamstore-a.akamaihd.net/news/externalpost/steam_community_announcements/5759616966668990190"
      is_external_url: Bool true
      author: String "erics"
      contents: String "{STEAM_CLA..."
      feedlabel: String "Community Announcements"
      date: Dates.DateTime
        instant: Dates.UTInstant{Dates.Millisecond}
          periods: Dates.Millisecond
            value: Int64 63849838959000
      feedname: String "steam_community_announcements"
      feed_type: Int64 1
      tags: Nothing nothing
  count: Int64 3545
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