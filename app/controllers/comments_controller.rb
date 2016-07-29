class CommentsController < ApplicationController
  def create
		@service_transaction = ServiceTransaction.find(params[:service_transaction_id])
		@comment = Comment.create(params[:comment].permit(:content))
		@comment.user_id = current_user.id
		@comment.service_transaction_id = @service_transaction.id

		if @comment.save 
			if current_user.role.name == "user"
				CommentMailer.new_user_comment_to_staff(@comment).deliver_later
				CommentMailer.new_user_comment_to_technician(@comment).deliver_later
				create_notification_to_staff @service_transaction, @comment
				create_notification_to_technician @service_transaction, @comment
			elsif current_user.role.name == "staff"
				CommentMailer.new_staff_comment_to_user(@comment).deliver_later
				CommentMailer.new_staff_comment_to_technician(@comment).deliver_later
				create_notification_for_user @service_transaction, @comment
				create_notification_to_technician @service_transaction, @comment
			elsif current_user.role.name == "technician"
				CommentMailer.new_technician_comment_to_user(@comment).deliver_later
				CommentMailer.new_technician_comment_to_staff(@comment).deliver_later
				create_notification_for_user @service_transaction, @comment
				create_notification_to_staff @service_transaction, @comment
			else
				create_notification_to_technician @service_transaction, @comment
				create_notification_for_user @service_transaction, @comment
				create_notification_to_staff @service_transaction, @comment
			end
			redirect_to service_transaction_path(@service_transaction)
			# if @comment.user.admin? || @comment.user.technician
			# 	CommentMailer.new_comment(@comment).deliver
			# else
			# 	CommentMailer.new_user_comment(@comment).deliver
			# end
		else
			redirect_to service_transaction_path(@service_transaction), notice: "Comment cannot be blank"
		end
	
  end
	  def create_notification_to_staff(car, comment)  
	    #return if @service_transaction.car.user.id == current_user.id 
	    Notification.create(user_id: @service_transaction.staff_in_charge_id,
	                        notified_by_id: current_user.id,
	                        car_id: @service_transaction.car_id,
	                        service_transaction_id: @service_transaction.id,
	                   
	                        notice_type: 'created a new comment')
	  end  
	  def create_notification_for_user(car, comment)  
	    #return if @service_transaction.car.user.id == current_user.id 
	    Notification.create(user_id: @service_transaction.car.user_id,
	                        notified_by_id: current_user.id,
	                        car_id: @service_transaction.car_id,
	                        service_transaction_id: @service_transaction.id,
	                        notice_type: 'created a new comment')
	  end
	    def create_notification_to_technician(car, comment)  
	    #return if @service_transaction.car.user.id == current_user.id 
	    Notification.create(user_id: @service_transaction.technician_in_charge_id,
	                        notified_by_id: current_user.id,
	                        car_id: @service_transaction.car_id,
	                        service_transaction_id: @service_transaction.id,
	                   
	                        notice_type: 'created a new comment')
	  end  
end
