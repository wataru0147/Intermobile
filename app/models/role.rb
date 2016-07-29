class Role < ActiveRecord::Base

	has_many :users

	validates :name, uniqueness: true, presence: true
end
