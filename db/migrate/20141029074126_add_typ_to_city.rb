class AddTypToCity < ActiveRecord::Migration
  def change
    add_column :cities, :typ, :string
  end
end
