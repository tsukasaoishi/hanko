require 'test_helper'
require 'expect_set'

class HankoTest < ActionView::TestCase
  tests HankoTarget
  include ExpectSet

  def setup
    Hanko::Fingerprint.digest_class = Digest::SHA256
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

  test "do not add fingerprint to fullpath url" do
    url = "http://kaeruspoon.net/tsu.js"
    assert_equal url, stylesheet_path(url)
  end

  test "do not add fingerprint to toplevel path" do
    assert_equal "/tsuka.js", javascript_path("/tsuka")
  end

  test "do not add fingerprint to path with query_string or anchor" do
    assert_equal "/javascripts/tsuka.js?a=1", javascript_path("tsuka.js?a=1")
    assert_equal "/javascripts/tsuka.js#1", javascript_path("tsuka.js#1")
  end

  test "do not add fingerprint to path of directory" do
    assert_equal "/images/dummy_dir", image_path("dummy_dir")
  end
end
