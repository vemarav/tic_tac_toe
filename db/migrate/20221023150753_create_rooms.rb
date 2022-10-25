class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :slug
      t.text   :board, array: true, default: []
      t.string :current, default: 'X'
      t.string :players, array: true, default: []

      t.timestamps
    end
    add_index :rooms, :slug, unique: true
  end
end
