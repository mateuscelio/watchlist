class AlertsController < ApplicationController
  before_action :authenticate_user!

  def index
    assets_symbols = current_user.wallet.items.map { |item| item.asset.symbol }
    @alerts = Alert.messages_with_symbols(assets_symbols)
                   .order(created_at: :desc)
                   .limit(30)
  end
end
