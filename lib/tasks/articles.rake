namespace :articles do
  desc "refreshes eth cache of portfolios"
  task :refresh_cache, [:symbol] => :environment do |task, args|
    articles = MediumService.new.get_latest_articles
    Rails.cache.write("api:articles", articles, expires_in: 24.hours)
  end
end
