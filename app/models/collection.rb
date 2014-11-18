class Collection < ActiveRecord::Base
  attr_accessible :category_id, :language, :name
  belongs_to :category



  def self.import(file , category)
  	CSV.foreach(file.path,headers: true) do |row| 
  		if(!find_by_name(row["name"]).present?)
  			category.collections.create! row.to_hash 
  		end
  	end
  end
end
