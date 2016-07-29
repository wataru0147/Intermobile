require 'test_helper'

class ServiceTransactionMailerTest < ActionMailer::TestCase
  test "finished" do
    mail = ServiceTransactionMailer.finished
    assert_equal "Finished", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
