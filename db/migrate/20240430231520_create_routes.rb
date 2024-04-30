class CreateRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :routes do |t|
      t.string :name
      t.integer :length
      t.string :grade
      t.integer :style
      t.boolean :sport
      t.integer :bolts
      t.references :crag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
