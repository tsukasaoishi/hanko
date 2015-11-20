module Hanko
  class Init
    def initialize(digest_class = nil)
      @digest_class = digest_class
    end

    def ready
      Hankan::Fingerprint.digest_class = @digest_class if @digest_class

      if exist_asset_paths?
        prepend_asset_paths
      else
        prepend_asset_url_helper
      end
    end

    def prepend_asset_url_helper
      require "hanko/asset_url_helper"
      ActionView::Base.__send__(
        :prepend, Hanko::AssetUrlHelper
      )
    end

    def prepend_asset_paths
      require "hanko/asset_paths"
      ActionView::Helpers::AssetTagHelper::AssetPaths.__send__(
        :prepend, Hanko::AssetPaths
      )
    end

    def exist_asset_paths?
      defined?(ActionView::Helpers::AssetTagHelper::AssetPaths)
    end
  end
end
