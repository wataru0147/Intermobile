require 'test_helper'

class ServiceTodoMailerTest < ActionMailer::TestCase
  test "on_going" do
    mail = ServiceTodoMailer.on_going
    assert_equal "On going", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "completed" do
    mail = ServiceTodoMailer.completed
    assert_equal "Completed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
