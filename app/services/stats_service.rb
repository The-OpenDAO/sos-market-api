class StatsService
  attr_accessor :actions, :bonds

  def initialize
    @actions = Bepro::PredictionMarketContractService.new.get_action_events
    @bonds = Bepro::RealitioErc20ContractService.new.get_bond_events
  end

  def stats
    # TODO: volume chart
    # TODO: TVL chart

    {
      markets_created: Market.published.count,
      bond_volume: bonds.sum { |bond| bond[:value] },
      volume: volume.sum { |v| v[:value] },
      fees: volume.sum { |v| v[:value] } * 0.02
    }
  end

  def volume
    actions.select { |v| ['buy', 'sell'].include?(v[:action]) }
  end
end
