class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :banner

      t.timestamps null: false
    end
  end
end
