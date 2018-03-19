class AddValueTwoToCharts < ActiveRecord::Migration
  def change
    add_column :charts, :value_two, :string
  end
end
