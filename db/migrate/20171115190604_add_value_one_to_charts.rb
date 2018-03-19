class AddValueOneToCharts < ActiveRecord::Migration
  def change
    add_column :charts, :value_one, :string
  end
end
