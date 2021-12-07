namespace :portfolios do
  desc "refreshes eth cache of portfolios"
  task :refresh_cache, [:symbol] => :environment do |task, args|
    Portfolio.all.each { |p| p.refresh_cache! }
  end

  task :monitor_overflow_status, [:symbol] => :environment do |task, args|
    bepro = Bepro::PredictionMarketContractService.new

    # fetching unique user/market pairs
    actions = bepro.get_action_events
    lookups = actions.map { |a| { user: a[:address], market_id: a[:market_id] } }.uniq

    lookups.each do |lookup|
      begin
        # looking for revert SafeMath: subtraction overflow error
        bepro.call(method: 'getUserClaimableFees', args: [lookup[:market_id], lookup[:user]])
      rescue => e
        Sentry.capture_message("SafeMath: subtraction overflow :: User #{lookup[:user]}, Market #{lookup[:market_id]} - #{e.message}") if (e.message.include?('SafeMath'))
      end
    end
  end
end
