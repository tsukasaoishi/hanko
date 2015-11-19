require 'hanko/digest'

module Hanko
  module AssetPaths
    private

    def rails_asset_id(source)
      if self.cache_asset_ids && (asset_id = self.asset_ids_cache[source])
        asset_id
      else
        path = File.join(config.assets_dir, source)
        asset_id = File.exist?(path) ? Hanko::Digest.file_digest(path) : ''

        add_to_asset_ids_cache(source, asset_id) if self.cache_asset_ids

        asset_id
      end
    end
  end
end
