class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :english
      t.string :urdu

      t.timestamps
    end
  end
end
