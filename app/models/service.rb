class Service < ActiveRecord::Base
	has_many :service_todos

	validates :name, uniqueness: true
	validates :price, presence: true
	validates :name, presence: true
    def self.search(search)
	    if search
	      where(["name LIKE ?" , "%#{search}%"])
	    else
	      all
	    end    
  	end
end
