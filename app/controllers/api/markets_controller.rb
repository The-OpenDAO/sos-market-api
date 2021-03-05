# frozen_string_literal: true
module Api
  class MarketsController < BaseController
    def index
      render json: [], status: :ok
    end

    def show
      render json: {}, status: :ok
    end
  end
end
