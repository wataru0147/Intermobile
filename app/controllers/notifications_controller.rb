class NotificationsController < ApplicationController
  def link_through  
	  @notification = Notification.find(params[:id])
	  @notification.update read: true
	  redirect_to service_transaction_path @notification.service_transaction
  end  
end
