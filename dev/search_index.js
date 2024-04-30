var documenterSearchIndex = {"docs":
[{"location":"ISteamNews/#News","page":"ISteamNews","title":"News","text":"","category":"section"},{"location":"ISteamNews/","page":"ISteamNews","title":"ISteamNews","text":"get_news_for_app","category":"page"},{"location":"ISteamNews/#SteamWebAPIs.get_news_for_app","page":"ISteamNews","title":"SteamWebAPIs.get_news_for_app","text":"get_news_for_app(appid::Int;\n    maxlength::Int=0,\n    enddate::DateTime=now(),\n    count::Int=20,\n    feeds::Vector{String}=String[],\n    tages::Vector{String}=String[])::Appnews\n\nSummary: get_news_for_app returns the latest of a game specified by its AppID.\n\nArguments\n\nappid: AppID of the game you want the news of.\n\nOptional keywords\n\nmaxlength: Maximum length of each news entry.\nenddate: Retrieve posts earlier than this date (unix epoch timestamp)\ncount: How many news enties you want to get returned.\nfeeds: Comma-separated list of feed names to return news for\ntages: Comma-separated list of tags to filter by (e.g. 'patchnodes')\n\nExample\n\njulia> dump(get_news_for_app(440;maxlength=10,enddate=now(),count=1,feeds=[\"steam_updates\",\"tf2_blog\"]))\n    Steam.Appnews\n    appid: Int64 440\n    newsitems: Array{Steam.NewsItem}((1,))\n        1: Steam.NewsItem\n        gid: Int64 5762994032406766352\n        title: String \"Team Fortress 2 Update Released\"\n        url: String \"https://store.steampowered.com/news/220641/\"\n        is_external_url: Bool false\n        author: String \"Valve\"\n        contents: String \"An update ...\"\n        feedlabel: String \"Product Update\"\n        date: Int64 1713822840\n        feedname: String \"steam_updates\"\n        feed_type: Int64 0\n        tags: Nothing nothing\n    count: Int64 1961\n\n\n\n\n\n","category":"function"},{"location":"ISteamNews/","page":"ISteamNews","title":"ISteamNews","text":"SteamWebAPIs.Appnews","category":"page"},{"location":"ISteamNews/#SteamWebAPIs.Appnews","page":"ISteamNews","title":"SteamWebAPIs.Appnews","text":"struct Appnews\n    appid::Int\n    newsitems::Vector{NewsItem}\n    count::Int\nend\n\nReturn type of get_news_for_app.\n\nFields:\n\nappid: AppID of the game you want the news of.\nnewsitems: Vector of NewsItem.\ncount: Total news count for this game.\n\n\n\n\n\n","category":"type"},{"location":"ISteamNews/","page":"ISteamNews","title":"ISteamNews","text":"SteamWebAPIs.NewsItem","category":"page"},{"location":"ISteamNews/#SteamWebAPIs.NewsItem","page":"ISteamNews","title":"SteamWebAPIs.NewsItem","text":"struct NewsItem\n    gid::Int\n    title::String\n    url::String\n    is_external_url::Bool\n    author::String\n    contents::String\n    feedlabel::String\n    date::Int\n    feedname::String\n    feed_type::Int\n    tags::Union{Vector{String},Nothing}\nend\n\nGet game news by id.\n\nFields:\n\ngid: News ID.\ntitle: News title.\nurl: News url.\nis_external_url: Is this news URL points to a non-Steam site.\nauthor: News author.\ncontents: News contents, The length is determined by the maxlength keywords.\nfeedlabel: News feedlabel.\ndate: News publish date (unix time stamp).\nfeedname: News feedname.\nfeed_type: News type.\ntags: News tags.\n\n\n\n\n\n","category":"type"},{"location":"ISteamUser/#Player-Summaries","page":"ISteamUser","title":"Player Summaries","text":"","category":"section"},{"location":"ISteamUser/","page":"ISteamUser","title":"ISteamUser","text":"get_player_summaries","category":"page"},{"location":"ISteamUser/#SteamWebAPIs.get_player_summaries","page":"ISteamUser","title":"SteamWebAPIs.get_player_summaries","text":"get_player_summaries(steamids::Vector{Int})::Vector{Player}\n\nSummary: get_player_summaries returns basic profile information for a list of 64-bit Steam IDs.\n\nArguments\n\nsteamids: Vector of 64 bit Steam IDs to return profile information for. Up to 100 Steam IDs can be requested.\n\nExample\n\njulia> dump(get_player_summaries([76561198202322924]))\nArray{SteamWebAPIs.Player}((1,))\n  1: SteamWebAPIs.Player\n    steamid: Int64 76561198202322924\n    communityvisibilitystate: Int64 3\n    profilestate: Int64 1\n    personaname: String \"archlinux\"\n    profileurl: String \"https://steamcommunity.com/id/NeroBlackstone/\"\n    avatar: String \"https://avatars.steamstatic.com/8968076741d594170face46a70c7d0bb92c14f69.jpg\"\n    avatarmedium: String \"https://avatars.steamstatic.com/8968076741d594170face46a70c7d0bb92c14f69_medium.jpg\"\n    avatarfull: String \"https://avatars.steamstatic.com/8968076741d594170face46a70c7d0bb92c14f69_full.jpg\"\n    avatarhash: String \"8968076741d594170face46a70c7d0bb92c14f69\"\n    lastlogoff: Int64 1713382544\n    personastate: Int64 0\n    primaryclanid: Int64 103582791429521408\n    timecreated: Int64 1434629419\n    personastateflags: Int64 0\n    loccountrycode: String \"CN\"\n    locstatecode: String \"03\"\n    loccityid: Int64 10221\n    realname: Nothing nothing\n    gameextrainfo: Nothing nothing\n    gameid: Nothing nothing\n\n\n\n\n\n","category":"function"},{"location":"ISteamUser/","page":"ISteamUser","title":"ISteamUser","text":"get_friend_list","category":"page"},{"location":"ISteamUser/#SteamWebAPIs.get_friend_list","page":"ISteamUser","title":"SteamWebAPIs.get_friend_list","text":"get_friend_list(steamid::Int)::Vector{Friend}\n\nSummary: get_friend_list returns the friend list of any Steam user, provided their Steam Community profile visibility is set to \"Public\". Nothing will be returned if the profile is private.\n\nArguments\n\nsteamid: 64 bit Steam ID to return friend list for.\n\nExample\n\njulia> get_friend_list(76561198202322924)\nArray{SteamWebAPIs.Friend}((1792,))\n  1: SteamWebAPIs.Friend\n    steamid: String \"76561197960270682\"\n    friend_since: Int64 1647624586\n  2: SteamWebAPIs.Friend\n    steamid: String \"76561197960279742\"\n    friend_since: Int64 1710223571\n  ...\n  1791: SteamWebAPIs.Friend\n    steamid: String \"76561199654378722\"\n    friend_since: Int64 1713115188\n  1792: SteamWebAPIs.Friend\n    steamid: String \"76561199664162819\"\n    friend_since: Int64 1713456325\n\n\n\n\n\n","category":"function"},{"location":"ISteamUser/","page":"ISteamUser","title":"ISteamUser","text":"SteamWebAPIs.Friend","category":"page"},{"location":"ISteamUser/#SteamWebAPIs.Friend","page":"ISteamUser","title":"SteamWebAPIs.Friend","text":"struct Friend\n    steamid::String\n    friend_since::Int\nend\n\nReturn type of get_friend_list.\n\nFields:\n\nsteamid: 64bit SteamID of the friend.\nfriend_since: Unix timestamp of the time when the relationship was created.\n\n\n\n\n\n","category":"type"},{"location":"ISteamUser/","page":"ISteamUser","title":"ISteamUser","text":"SteamWebAPIs.Player","category":"page"},{"location":"ISteamUser/#SteamWebAPIs.Player","page":"ISteamUser","title":"SteamWebAPIs.Player","text":"struct Player\n    # Public Data\n    steamid::Int\n    communityvisibilitystate::Int\n    profilestate::Int\n    personaname::String\n    profileurl::String\n    avatar::String\n    avatarmedium::String\n    avatarfull::String\n    avatarhash::String\n    lastlogoff::Union{Int,Nothing}\n    personastate::Int\n    # Private Data\n    primaryclanid::Int\n    timecreated::Int\n    personastateflags::Int\n    loccountrycode::Union{String,Nothing}\n    locstatecode::Union{Int,Nothing}\n    loccityid::Union{Int,Nothing}\n    realname::Union{String,Nothing}\n    gameextrainfo::Union{String,Nothing}\n    gameid::Union{Int,Nothing}\nend\n\nReturn type of get_player_summaries.\n\nFields:\n\nsteamid: 64bit SteamID of the user.\ncommunityvisibilitystate: This represents whether the profile is visible or not, and if it is visible, why you are allowed to see it. Note that because this WebAPI does not use authentication, there are only two possible values returned: 1 - the profile is not visible to you (Private, Friends Only, etc), 3 - the profile is \"Public\", and the data is visible.\nprofilestate: If set, indicates the user has a community profile configured (will be set to '1')\npersonaname: The player's persona name (display name)\nprofileurl: The full URL of the player's Steam Community profile.\navatar: The full URL of the player's 32x32px avatar. If the user hasn't configured an avatar, this will be the default ? avatar.\navatarmedium: The full URL of the player's 64x64px avatar. If the user hasn't configured an avatar, this will be the default ? avatar.\navatarfull: The full URL of the player's 184x184px avatar. If the user hasn't configured an avatar, this will be the default ? avatar.\navatarhash: Unknow.\nlastlogoff: The last time the user was online, in unix time.\npersonastate: The user's current status. 0 - Offline, 1 - Online, 2 - Busy, 3 - Away, 4 - Snooze, 5 - looking to trade, 6 - looking to play. If the player's profile is private, this will always be \"0\", except is the user has set their status to looking to trade or looking to play, because a bug makes those status appear even if the profile is private.\nprimaryclanid: The player's primary group, as configured in their Steam Community profile.\ntimecreated: The time the player's account was created.\npersonastateflags: Unknow.\nloccountrycode: If set on the user's Steam Community profile, The user's country of residence, 2-character ISO country code\nlocstatecode: If set on the user's Steam Community profile, The user's state of residence.\nloccityid: An internal code indicating the user's city of residence. A future update will provide this data in a more useful way.\nrealname: The player's \"Real Name\", if they have set it.\ngameextrainfo: If the user is currently in-game, this will be the name of the game they are playing. This may be the name of a non-Steam game shortcut.\ngameid: If the user is currently in-game, this value will be returned and set to the gameid of that game.\n\n\n\n\n\n","category":"type"},{"location":"QueryLocations/#QueryLocations","page":"QueryLocations","title":"QueryLocations","text":"","category":"section"},{"location":"QueryLocations/","page":"QueryLocations","title":"QueryLocations","text":"get_countries","category":"page"},{"location":"QueryLocations/#SteamWebAPIs.get_countries","page":"QueryLocations","title":"SteamWebAPIs.get_countries","text":"get_countries()::Dict{String,Tuple{Bool,String}}\n\nSummary: get_countries returns a Dict of Countries,key is country code, value is a Tuple, the first element of Tuple indicates whether there has stete, the second is countryname.\n\nExample\n\njulia> get_countries()\ncountries = Dict(\"ES\" => (1, \"Spain\")......\"SM\" => (1, \"San Marino\"))\n\n\n\n\n\n","category":"function"},{"location":"QueryLocations/","page":"QueryLocations","title":"QueryLocations","text":"get_states","category":"page"},{"location":"QueryLocations/#SteamWebAPIs.get_states","page":"QueryLocations","title":"SteamWebAPIs.get_states","text":"get_states(countrycode::String)::Dict{String,String}\n\nSummary: get_states returns a Dict of States by countrycode, key is state code, value is state name.\n\nArguments\n\ncountrycode: Country code to be queried.\n\nExample\n\njulia> get_states(\"CN\")\nDict(\"24\" => \"Shanxi\", \"29\" => \"Yunnan\", \"32\" => \"Sichuan\", \"07\" => \"Fujian\", \"12\" => \"Hubei\", \"20\" => \"Nei Mongol\", \"06\" => \"Qinghai\", \"25\" => \"Shandong\", \"03\" => \"Jiangxi\", \"22\" => \"Beijing\", \"11\" => \"Hunan\", \"23\" => \"Shanghai\", \"13\" => \"Xinjiang\", \"15\" => \"Gansu\", \"04\" => \"Jiangsu\", \"31\" => \"Hainan\", \"33\" => \"Chongqing\", \"28\" => \"Tianjin\", \"16\" => \"Guangxi\", \"14\" => \"Xizang\", \"21\" => \"Ningxia\", \"09\" => \"Henan\", \"05\" => \"Jilin\", \"01\" => \"Anhui\", \"08\" => \"Heilongjiang\", \"26\" => \"Shaanxi\", \"10\" => \"Hebei\", \"19\" => \"Liaoning\", \"18\" => \"Guizhou\", \"02\" => \"Zhejiang\", \"30\" => \"Guangdong\")\n\n\n\n\n\n","category":"function"},{"location":"QueryLocations/","page":"QueryLocations","title":"QueryLocations","text":"get_cities","category":"page"},{"location":"QueryLocations/#SteamWebAPIs.get_cities","page":"QueryLocations","title":"SteamWebAPIs.get_cities","text":"get_cities(countrycode::String,statecode::String)::Dict{Int,String}\n\nSummary: get_cities returns a Dict of Cities by countrycode and statecode, key is city code, value is city name.\n\nArguments\n\ncountrycode: Country code to be queried.\nstatecode: State code to be queried.\n\nExample\n\njulia> get_cities(\"CN\",\"01\")\ncites = Dict(10398 => \"Wucheng\", 10455 => \"Xuanzhou\", 9855 => \"Bengbu\", 10013 => \"Hefei\", 9830 => \"Anqing\", 10058 => \"Huoqiu\", 10035 => \"Huainan\", 10492 => \"Yingshang\", 9967 => \"Fuyang\", 10186 => \"Lujiang\", 10031 => \"Huaibei\", 9883 => \"Chaohu\", 9909 => \"Dangtu\", 10196 => \"Maanshan\", 9898 => \"Chuzhou\", 10347 => \"Suzhou\", 10375 => \"Tongling\", 9894 => \"Chizhou\", 9866 => \"Bozhou\", 10206 => \"Mengcheng\", 10363 => \"Tangzhai\", 10211 => \"Mingguang\", 10037 => \"Huaiyuan\", 10401 => \"Wuhu\", 10083 => \"Jieshou\", 10184 => \"Luan\", 10343 => \"Suixi\", 10381 => \"Tunxi\")\n\n\n\n\n\n","category":"function"},{"location":"ISteamUserStats/#Achievement-Percentage","page":"ISteamUserStats","title":"Achievement Percentage","text":"","category":"section"},{"location":"ISteamUserStats/","page":"ISteamUserStats","title":"ISteamUserStats","text":"get_global_achievement_percentages_for_app","category":"page"},{"location":"ISteamUserStats/#SteamWebAPIs.get_global_achievement_percentages_for_app","page":"ISteamUserStats","title":"SteamWebAPIs.get_global_achievement_percentages_for_app","text":"get_global_achievement_percentages_for_app(gameid::Int)::Vector{Achievement}\n\nSummary: get_global_achievement_percentages_for_app returns on global achievements overview of a specific game in percentages.\n\nArguments\n\ngameid: GameID to retrieve the achievement percentages for.\n\nExample\n\njulia> dump(get_global_achievement_percentages_for_app(440))\nArray{SteamWebAPIs.AchievementPercentage}((520,))\n  1: SteamWebAPIs.Achievement\n    name: String \"TF_SCOUT_LONG_DISTANCE_RUNNER\"\n    percent: Float16 Float16(51.4)\n  2: SteamWebAPIs.Achievement\n    name: String \"TF_HEAVY_DAMAGE_TAKEN\"\n    percent: Float16 Float16(41.7)\n  ...\n  519: SteamWebAPIs.Achievement\n    name: String \"TF_PASS_TIME_HAT\"\n    percent: Float16 Float16(3.7)\n  520: SteamWebAPIs.Achievement\n    name: String \"TF_PASS_TIME_GRIND\"\n    percent: Float16 Float16(3.0)\n\n\n\n\n\n","category":"function"},{"location":"ISteamUserStats/","page":"ISteamUserStats","title":"ISteamUserStats","text":"get_player_achievements","category":"page"},{"location":"ISteamUserStats/#SteamWebAPIs.get_player_achievements","page":"ISteamUserStats","title":"SteamWebAPIs.get_player_achievements","text":"get_player_achievements(steamid::Int,appid::Int;l::String)::PlayerAchievements\n\nSummary: get_player_achievements returns a list of achievements for this user by app id.\n\nArguments\n\nsteamid: 64 bit Steam ID to return friend list for.\nappid: The ID for the game you're requesting.\nl: Language. If specified, it will return language data for the requested language.\n\nExample\n\njulia> dump(get_player_achievements(76561198309475951,553850;l=\"japanese\"))\nSteamWebAPIs.PlayerAchievements\n  gameName: String \"HELLDIVERS™ 2\"\n  achievements: Array{SteamWebAPIs.Achievement}((38,))\n    1: SteamWebAPIs.Achievement\n      apiname: String \"1\"\n      achieved: Bool false\n      unlocktime: Int64 0\n      name: String \"ヘルダイブ\"\n      description: String \"難易度がエクストリーム以上のミッションを、誰も死ぬことなく完了する\"\n    2: SteamWebAPIs.Achievement\n      apiname: String \"2\"\n      achieved: Bool false\n      unlocktime: Int64 0\n      name: String \"武器はいらない\"\n      description: String \"難易度がハード以上のミッションを、誰一人メインウェポンまたは支援武器を発砲せずに完了する\"\n    ...\n    37: SteamWebAPIs.Achievement\n      apiname: String \"37\"\n      achieved: Bool true\n      unlocktime: Int64 1710519126\n      name: String \"夜になると現れる\"\n      description: String \"夜間にミッションから離脱する\"\n    38: SteamWebAPIs.Achievement\n      apiname: String \"38\"\n      achieved: Bool true\n      unlocktime: Int64 1710565961\n      name: String \"管理民主主義を広めよ\"\n      description: String \"１つのミッション中に敵を150体倒す\"\n\n\n\n\n\n","category":"function"},{"location":"ISteamUserStats/","page":"ISteamUserStats","title":"ISteamUserStats","text":"SteamWebAPIs.AchievementPercentage","category":"page"},{"location":"ISteamUserStats/#SteamWebAPIs.AchievementPercentage","page":"ISteamUserStats","title":"SteamWebAPIs.AchievementPercentage","text":"struct AchievementPercentage\n    name::String\n    percent::Float16\nend\n\nReturn type of get_global_achievement_percentages_for_app.\n\nFields:\n\nname: Name of the achievement you want the game of.\npercent: Achievement achieved percentage.\n\n\n\n\n\n","category":"type"},{"location":"ISteamUserStats/","page":"ISteamUserStats","title":"ISteamUserStats","text":"SteamWebAPIs.PlayerAchievements","category":"page"},{"location":"ISteamUserStats/#SteamWebAPIs.PlayerAchievements","page":"ISteamUserStats","title":"SteamWebAPIs.PlayerAchievements","text":"struct PlayerAchievements\n    gameName::String\n    achievements::Vector{Achievement}\nend\n\nReturn type of get_player_achievements.\n\nFields:\n\ngameName: Name of the game.\nachievements: Vector of Achievement.\n\n\n\n\n\n","category":"type"},{"location":"ISteamUserStats/","page":"ISteamUserStats","title":"ISteamUserStats","text":"SteamWebAPIs.Achievement","category":"page"},{"location":"ISteamUserStats/#SteamWebAPIs.Achievement","page":"ISteamUserStats","title":"SteamWebAPIs.Achievement","text":"struct Achievement\n    apiname::String\n    achieved::Bool\n    unlocktime::Int\n    name::Union{String,Nothing}\n    description::Union{String,Nothing}\nend\n\nAchievement item.\n\nFields:\n\napiname: The API name of the achievement.\nachieved: Whether or not the achievement has been completed.\nunlocktime: Date when the achievement was unlocked.\nname: Localized achievement name.\ndescription: Localized description of the achievement.\n\n\n\n\n\n","category":"type"},{"location":"#SteamWebAPIs.jl","page":"SteamWebAPIs.jl","title":"SteamWebAPIs.jl","text":"","category":"section"},{"location":"","page":"SteamWebAPIs.jl","title":"SteamWebAPIs.jl","text":"Steam Web API wrapper for Julia","category":"page"},{"location":"#API-Key","page":"SteamWebAPIs.jl","title":"API Key","text":"","category":"section"},{"location":"","page":"SteamWebAPIs.jl","title":"SteamWebAPIs.jl","text":"Please apply for your steam api key first. Then paste your api key at $HOME/.steam/apikey.txt. Or save api key to STEAM_KEY environment variable.","category":"page"},{"location":"#Initialization","page":"SteamWebAPIs.jl","title":"Initialization","text":"","category":"section"},{"location":"","page":"SteamWebAPIs.jl","title":"SteamWebAPIs.jl","text":"Before calling any interface that requires an API key, you need to initialize the Steam Web API key with init_key(). Otherwise, you can only call interfaces that do not require an API key.","category":"page"},{"location":"","page":"SteamWebAPIs.jl","title":"SteamWebAPIs.jl","text":">julia init_key()","category":"page"},{"location":"#Implemented-functions","page":"SteamWebAPIs.jl","title":"Implemented functions","text":"","category":"section"},{"location":"","page":"SteamWebAPIs.jl","title":"SteamWebAPIs.jl","text":"get_news_for_app\nget_player_summaries\nget_global_achievement_percentages_for_app\nget_countries\nget_states\nget_cities\nget_friend_list\nget_player_achievements","category":"page"}]
}
