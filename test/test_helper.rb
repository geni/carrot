dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'
require 'carrot'
require 'minitest/autorun'
require 'pp'

class TestHelper < MiniTest::Test

  def self.test(name, &block)
    define_method("test_#{name.gsub(/\W/,'_')}", &block) if block
  end

end # class TestHelper
