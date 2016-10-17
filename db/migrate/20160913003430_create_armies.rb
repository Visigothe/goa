class CreateArmies < ActiveRecord::Migration[5.0]
  def change
    create_table :armies do |t|
      t.string :name
      t.string :faction
      t.string :force_size

      t.timestamps
    end
  end
end
