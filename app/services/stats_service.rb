class StatsService
  attr_accessor :actions, :bonds

  def initialize
    @actions = Bepro::PredictionMarketContractService.new.get_action_events
    @bonds = Bepro::RealitioErc20ContractService.new.get_bond_events
  end

  def get_stats
    # TODO: volume chart
    # TODO: TVL chart
    bonds_volume = bonds.sum { |bond| bond[:value] }
    volume_movr = volume.sum { |v| v[:value] }
    fees_movr = volume.sum { |v| v[:value] } * 0.02

    {
      markets_created: Market.published.count,
      bond_volume: bonds_volume,
      bond_volume_eur: bonds_volume * rates[:polkamarkets],
      volume: volume_movr,
      volume_eur: volume_movr * rates[:moonriver],
      fees: fees_movr,
      fees_eur: fees_movr * rates[:moonriver]
    }
  end

  def volume
    actions.select { |v| ['buy', 'sell'].include?(v[:action]) }
  end

  def rates
    @_rates ||= TokenRatesService.new.get_rates(['polkamarkets', 'moonriver'], 'eur')
  end
end
