class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :eng_name
      t.string :urdu_name

      t.timestamps
    end
  end
end
