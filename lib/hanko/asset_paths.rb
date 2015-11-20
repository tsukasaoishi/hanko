module Hanko
  module AssetPaths
    private

    def rails_asset_id(source)
      Hanko::Fingerprint.pon(config.assets_dir, source)
    end
  end
end
