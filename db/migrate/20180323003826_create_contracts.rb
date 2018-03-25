class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :titulo
      t.text :descripcion

      t.timestamps null: false
    end
    add_attachment :contracts, :document
  end
end
