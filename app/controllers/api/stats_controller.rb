module Api
  class StatsController < BaseController
    def index
      stats = Rails.cache.fetch("api:stats", expires_in: 24.hours) do
        StatsService.new.get_stats
      end

      render json: stats, status: :ok
    end
  end
end
