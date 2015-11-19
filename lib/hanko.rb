require "hanko/version"
require "action_view"

if defined?(ActionPack) && ActionPack::VERSION::MAJOR == 3
  require "hanko/asset_paths"
  ActionView::Helpers::AssetTagHelper::AssetPaths.__send__(:prepend, Hanko::AssetPaths)
else
  require "hanko/asset_url_helper"
  ActionView::Base.__send__(:prepend, Hanko::AssetUrlHelper)
end
