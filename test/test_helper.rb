$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

module ExtendMinitest
  def test(name, &block)
    test_name = "test_#{name.gsub(/\s+/,'_')}"
    raise "test '#{name}' is already defined" if method_defined?(test_name)
    define_method(test_name, &block)
  end
end

unless defined?(Minitest::Test)
  Minitest::Test = Minitest::Unit::TestCase
end

Minitest::Test.extend ExtendMinitest

require 'action_view/test_case'
require 'hanko'
Hanko::Init.new.ready

if defined?(ActionView::Helpers::AssetTagHelper::AssetPaths)
  HankoTarget = Hanko::AssetPaths
else
  HankoTarget = Hanko::AssetUrlHelper
end
