class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.integer :category_id
      t.string :language

      t.timestamps
    end
  end
end
