class CommentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.new_user_comment_to_staff.subject
  #
  def new_user_comment_to_staff(comment)
    
    @comment = comment
    @service_transaction = @comment.service_transaction
    mail to: @service_transaction.staff_in_charge.email, subject: "New User Comment"
  end

  def new_user_comment_to_technician(comment)
    
    @comment = comment
    @service_transaction = @comment.service_transaction
    mail to: @service_transaction.technician_in_charge.email, subject: "New User Comment"
  end

  def new_staff_comment_to_user(comment)
    @comment = comment
    @service_transaction = @comment.service_transaction
    mail to: @service_transaction.car.user.email, subject: "New Staff Comment"
  end


  def new_staff_comment_to_technician(comment)
    @comment = comment
    @service_transaction = @comment.service_transaction
    mail to: @service_transaction.technician_in_charge.email , subject: "New Staff Comment"
  end

  def new_technician_comment_to_staff(comment)
    @comment = comment
    @service_transaction = @comment.service_transaction
    mail to: @service_transaction.staff_in_charge.email, subject: "New Technician Comment"
  end

  def new_technician_comment_to_user(comment)
    @comment = comment
    @service_transaction = @comment.service_transaction
    mail to: @service_transaction.car.user.email , subject: "New Technician Comment"
  end
end
