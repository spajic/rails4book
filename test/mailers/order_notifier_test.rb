require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Подтверждение заказа в rails4book", mail.subject
    assert_equal ["bs@gmail.com"], mail.to
    assert_equal ["bestspajic@gmail.com"], mail.from
    #assert_match /hello from rails4book/, mail.body.encoded # encoding issues
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "rails4book order shipped", mail.subject
    assert_equal ["bs@gmail.com"], mail.to
    assert_equal ["bestspajic@gmail.com"], mail.from
    assert_match "Hello from rails4book", mail.body.encoded
  end

end
