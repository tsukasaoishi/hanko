require 'test_helper'
require 'expect_set'

class HankoTest < ActionView::TestCase
  tests HankoTarget
  include ExpectSet

  def setup
    controller.config.assets_dir = File.join(__dir__, 'public')
  end

  def error_message(digest_class)
    "error digest class #{digest_class.name}"
  end

  test "image_path add fingerprint to generated url" do
    each_digests(type: :image) do |digest_class, fingerprint|
      assert_equal "/images/tsuka.png?#{fingerprint}", image_path("tsuka.png"),
        error_message(digest_class)
    end
  end

  test "javascript_path add fingerprint to generated url" do
    each_digests(type: :js) do |digest_class, fingerprint|
      assert_equal "/javascripts/tsuka.js?#{fingerprint}", javascript_path("tsuka"),
        error_message(digest_class)
    end
  end

  test "stylesheet_path add fingerprint to generated url" do
    each_digests(type: :css) do |digest_class, fingerprint|
      assert_equal "/stylesheets/tsuka.css?#{fingerprint}", stylesheet_path("tsuka"),
        error_message(digest_class)
    end
  end
end
