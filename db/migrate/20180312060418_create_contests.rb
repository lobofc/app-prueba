class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :titulo
      t.text :descripcion

      t.timestamps null: false
    end
    add_attachment :contests, :document
  end
end
