require 'test_helper'

class HankoTest < ActionView::TestCase
  if ActionPack::VERSION::MAJOR == 3
    tests Hanko::AssetPaths
  else
    tests Hanko::AssetUrlHelper
  end

  def setup
    controller.config.assets_dir = File.join(__dir__, 'public')
  end

  test "image_path add fingerprint to generated url" do
    expect_path = "/images/tsuka.png?ec0460828247a87f4a8f78a28a3b0545546833f0b3bd186f5352bb8bb8c673ca"
    assert_equal expect_path, image_path("tsuka.png")
  end

  test "javascript_path add fingerprint to generated url" do
    expect_path = "/javascripts/tsuka.js?035354580de79c3d4a7968c974df2ae76befa53dc1f3597507db0427dea4d09e"
    assert_equal expect_path, javascript_path("tsuka")
  end

  test "stylesheet_path add fingerprint to generated url" do
    expect_path = "/stylesheets/tsuka.css?5b59e7f86cc54cd79e0d6c12af4d053eaef6cc0be92598e5be335f83e036be14"
    assert_equal expect_path, stylesheet_path("tsuka")
  end
end
