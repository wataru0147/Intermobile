# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/comment_mailer/new_user_comment_to_staff
  def new_user_comment_to_staff
  	comment = Comment.last
    CommentMailer.new_user_comment_to_staff(comment)
  end

    def new_user_comment_to_technician
  	comment = Comment.last
    CommentMailer.new_user_comment_to_technician(comment)
  end

    def new_staff_comment_to_user
  	comment = Comment.last
    CommentMailernew_staff_comment_to_user(comment)
  end

    def new_staff_comment_to_technician
  	comment = Comment.last
    CommentMailer.new_staff_comment_to_technician(comment)
  end

    def new_technician_comment_to_staff
  	comment = Comment.last
    CommentMailer.new_technician_comment_to_staff(comment)
  end

    def new_technician_comment_to_user
  	comment = Comment.last
    CommentMailer.new_technician_comment_to_user(comment)
  end
end
