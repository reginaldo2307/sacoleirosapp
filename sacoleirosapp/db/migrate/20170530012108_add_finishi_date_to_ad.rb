class AddFinishiDateToAd < ActiveRecord::Migration
  def change
    add_column :ads, :finishi_date, :date
  end
end
