require 'rails_helper'

RSpec.describe Alert, type: :model do
  let!(:user) { create(:user) }
  let!(:wallet) { create(:wallet, user: user) }
  let!(:assets) { create_list(:asset, 5) }
  let!(:wallet_items) do
    create(:wallet_item, asset: assets.first, wallet: wallet)
    create(:wallet_item, asset: assets.second, wallet: wallet)
  end
  let!(:alerts) do
    assets[..1].map { |asset| create(:alert, message: "Test #{asset.symbol}") }
  end

  it 'returns only alerts of assets in user wallets' do
    expect(Alert.messages_with_symbols(user.wallet.items.map(&:symbol))).to match_array(alerts)
  end
end
