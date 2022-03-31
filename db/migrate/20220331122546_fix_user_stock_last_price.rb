class FixUserStockLastPrice < ActiveRecord::Migration[6.0]
  def change
    change_column :stocks, :last_price, :decimal ,precision: 6, scale: 2
  end
end
