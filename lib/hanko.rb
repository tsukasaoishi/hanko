require "hanko/version"
require "hanko/fingerprint"
require "action_view"

if defined?(ActionView::Helpers::AssetTagHelper::AssetPaths)
  require "hanko/asset_paths"
  ActionView::Helpers::AssetTagHelper::AssetPaths.__send__(:prepend, Hanko::AssetPaths)
else
  require "hanko/asset_url_helper"
  ActionView::Base.__send__(:prepend, Hanko::AssetUrlHelper)
end
