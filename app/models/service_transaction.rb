class ServiceTransaction < ActiveRecord::Base
  belongs_to :car
  has_many :service_todos
  has_many :comments
  accepts_nested_attributes_for :service_todos
end
