module Hanko
  module AssetUrlHelper
    def compute_asset_path(source, options = {})
      source = super
      return source if source.include?("?")

      asset_id = Hanko::Fingerprint.pon(config.assets_dir, source)

      if asset_id.empty?
        source
      else
        "#{source}?#{asset_id}"
      end
    end
  end
end
