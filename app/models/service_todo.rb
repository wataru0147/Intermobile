class ServiceTodo < ActiveRecord::Base
  
  belongs_to :service_transaction
  belongs_to :service
  belongs_to :technician_in_charge, :class_name => 'User'
 
  


  scope :unpaid, -> {where(paid_at: nil)}
  scope :paid, -> {where.not(paid_at: nil)}
  validates :service_id, presence: true
  validates :technician_in_charge, presence: true
  
  def ongoing?
    !started_at.blank?
  end

  def completed?
  	!completed_at.blank? && !started_at.blank?
  end

  # def paid?
  # 	!paid_at.blank?
  # end

  
end
