require 'test_helper'

class CarrotTest < TestHelper

  def teardown
    queue.purge
  end

  test "large message" do
    msg = 'a' * 131_000
    queue.publish(msg)

    assert_equal msg, queue.pop(:ack => true)
  end

  test 'pop without ack redelivers after reset' do
    queue.publish('one')

    assert_equal 'one', queue.pop
    assert_equal 0, queue.message_count, 'queue should be considered empty'
    carrot.reset
    assert_equal 1, queue.message_count, 'old message should be retried'

    assert_equal 'one', queue.pop(:ack => false)
    assert_equal 0, queue.message_count, 'queue should be considered empty'
    carrot.reset
    assert_equal 1, queue.message_count, 'old message should be retried'

    assert_equal 'one', queue.pop(:ack => true)
    assert_equal 0, queue.message_count, 'queue should be considered empty'
    carrot.reset

    assert_nil   queue.pop(:ack => true)
  end

  test 'pop then ack empties queue' do
    queue.publish('one')

    assert_equal 'one', queue.pop
    queue.ack
    carrot.reset
    assert_nil queue.pop(:ack => true)
  end

  test 'naked ack does not raise error' do
    queue.ack
  end

  test "reset" do
    queue.purge
    queue.publish('test')
    carrot.reset
    assert_equal 1, queue.message_count
    queue.pop(:ack => true)
  end

private

  def carrot
    @carrot ||= Carrot.new
  end

  def queue(name='_carrot_test')
    @queue ||= carrot.queue(name)
  end

end # class CarrotTest
