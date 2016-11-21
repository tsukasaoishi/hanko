require 'test_helper'
require 'expect_set'

class HankoTest < ActionView::TestCase
  tests HankoTarget
  include ExpectSet

  def setup
    Hanko::Fingerprint.digest_class = Digest::SHA256
    controller.config.assets_dir = File.join(__dir__, 'public')
  end

  def error_message(digest_class, prefix: nil, suffix: nil)
    "error digest class #{digest_class.name} (prefix:#{prefix} suffix:#{suffix})"
  end

  def fingerprint(fp, options)
    fp = "#{options[:prefix]}#{fp}" if options[:prefix]
    fp = "#{fp}#{options[:suffix]}" if options[:suffix]
    fp
  end

  prefix_suffix_options = [
    {},
    { prefix: "test1-" },
    { suffix: "-test2" },
    { prefix: "test3-", suffix: "-test4" }
  ]

  test "image_path add fingerprint to generated url" do
    prefix_suffix_options.each do |options|
      each_digests(options.merge(type: :image)) do |digest_class, fp|
        assert_equal "/images/tsuka.png?#{fingerprint(fp, options)}", image_path("tsuka.png"),
          error_message(digest_class)
      end
    end
  end

  test "javascript_path add fingerprint to generated url" do
    prefix_suffix_options.each do |options|
      each_digests(options.merge(type: :js)) do |digest_class, fp|
        assert_equal "/javascripts/tsuka.js?#{fingerprint(fp, options)}", javascript_path("tsuka"),
          error_message(digest_class)
      end
    end
  end

  test "stylesheet_path add fingerprint to generated url" do
    prefix_suffix_options.each do |options|
      each_digests(options.merge(type: :css)) do |digest_class, fp|
        assert_equal "/stylesheets/tsuka.css?#{fingerprint(fp, options)}", stylesheet_path("tsuka"),
          error_message(digest_class)
      end
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
