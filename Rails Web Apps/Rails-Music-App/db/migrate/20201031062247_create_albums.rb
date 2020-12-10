class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.date :year, null: false
      t.string :location, null: false, default: "studio"
      t.integer :band_id, null: false

      t.timestamps
    end
  end
end
