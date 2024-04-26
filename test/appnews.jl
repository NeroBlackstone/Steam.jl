@testset "appnews" begin
	@test_throws DomainError get_news_for_app(440;maxlength=-1)
    
	appnews = get_news_for_app(440;maxlength=10,count=2)
    
	@test appnews.appid == 440
	@test length(appnews.newsitems) == 2

end