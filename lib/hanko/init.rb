require "hanko/asset_url_helper"

module Hanko
  class Init
    def initialize(digest_class = nil)
      @digest_class = digest_class
    end

    def ready
      Hanko::Fingerprint.digest_class = @digest_class if @digest_class
      ActionView::Base.prepend Hanko::AssetUrlHelper
    end
  end
end
