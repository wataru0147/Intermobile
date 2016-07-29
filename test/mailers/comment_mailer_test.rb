require 'test_helper'

class CommentMailerTest < ActionMailer::TestCase
  test "new_user_comment_to_technician" do
    mail = CommentMailer.new_user_comment_to_technician
    assert_equal "New user comment to technician", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
