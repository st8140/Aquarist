class CreateAquaria < ActiveRecord::Migration[6.0]
  def change
    create_table :aquaria do |t|
      t.text :aquarium_introduction
      t.string :aquarium_image
      t.integer :user_id

      t.timestamps
    end
  end
end
