require 'test_helper'

class CarrotTest < TestHelper

  test "large messages" do
    msg = 'a' * 1024 * 1024
    queue.publish(msg)
    assert_equal msg, queue.pop
  end

  test "reset" do
    count = queue.message_count
    queue.publish('test')
    carrot.reset
    assert_equal count + 1, queue.message_count
  end

private

  def carrot
    @carrot ||= Carrot.new
  end

  def queue(name='_carrot_test')
    @queue ||= carrot.queue(name)
  end

end # context 'test queue'
