class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.string :name
      t.string :file

      t.timestamps null: false
    end
  end
end
