class ServiceTodo < ActiveRecord::Base
  belongs_to :service_transaction
  belongs_to :service



  scope :unpaid, -> {where(paid_at: nil)}
  scope :paid, -> {where.not(paid_at: nil)}
  
  def ongoing?
    !started_at.blank?
  end

  def completed?
  	!completed_at.blank? && !started_at.blank?
  end

  def paid?
  	!paid_at.blank?
  end

  
end
