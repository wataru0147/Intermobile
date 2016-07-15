class CommentsController < ApplicationController
  def create
		@service_transaction = ServiceTransaction.find(params[:service_transaction_id])
		@comment = Comment.create(params[:comment].permit(:content))
		@comment.user_id = current_user.id
		@comment.service_transaction_id = @service_transaction.id

		if @comment.save
			redirect_to service_transaction_path(@service_transaction)
			# if @comment.user.admin? || @comment.user.technician
			# 	CommentMailer.new_comment(@comment).deliver
			# else
			# 	CommentMailer.new_user_comment(@comment).deliver
			# end
		else
			render 'new'
		end
	
  end
end
