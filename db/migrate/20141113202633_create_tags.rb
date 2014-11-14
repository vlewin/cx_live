class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.text :description
      t.string :value
      t.integer :image_id
    end
  end
end
