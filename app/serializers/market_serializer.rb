class MarketSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :description,
    :expires_at,
    :oracle_source,
    :state,
    :category,
    :subcategory,
    :image_url,
    :liquidity,
    :liquidity_price,
    :volume,
    :shares,
    :resolved_outcome_id,
  )

  has_many :outcomes, class_name: "MarketOutcome", serialize: "MarketOutcomeSerializer"

  def id
    # returning eth market id in chain, not db market
    object.eth_market_id
  end
end
