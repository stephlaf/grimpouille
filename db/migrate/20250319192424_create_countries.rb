class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :grading_system, null: false

      t.timestamps
    end
  end
end
