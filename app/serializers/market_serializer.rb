class MarketSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :slug,
    :title,
    :description,
    :created_at,
    :expires_at,
    :fee,
    :state,
    :verified,
    :category,
    :subcategory,
    :image_url,
    :liquidity,
    :liquidity_price,
    :volume,
    :shares,
    :question_id,
    :resolved_outcome_id,
    :voided,
    :trading_view_symbol,
    :question,
    :banner_url
  )

  has_many :outcomes, class_name: "MarketOutcome", serialize: "MarketOutcomeSerializer"

  def id
    # returning eth market id in chain, not db market
    object.eth_market_id
  end

  def question
    object.question_data
  end
end
