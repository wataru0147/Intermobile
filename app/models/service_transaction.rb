class ServiceTransaction < ActiveRecord::Base
  belongs_to :car

  has_many :service_todos
  has_many :comments
  has_many :notifications, dependent: :destroy
  accepts_nested_attributes_for :service_todos
  belongs_to :staff_in_charge, :class_name => 'User'
  belongs_to :technician_in_charge, :class_name => 'User'
  belongs_to :user

  validates :staff_in_charge_id , presence: true
  validates :technician_in_charge_id , presence: true
  validates :car_id 			, presence: true

  def finished?
  	!finished_at.blank?
  end

  def self.search(search)
    if search
      where(["id = ?" , "%#{search}%"])
    else
      all
    end    
  end
end
