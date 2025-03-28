class CreateClimbingRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :climbing_routes do |t|
      t.string :name
      t.string :grade
      t.integer :style
      t.references :crag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
