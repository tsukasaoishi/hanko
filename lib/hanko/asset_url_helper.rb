require 'hanko/digest'

module Hanko
  module AssetUrlHelper
    def compute_asset_path(source, options = {})
      source = super
      return source if source.include?("?")

      path = File.join(config.assets_dir, source)
      asset_id = File.exist?(path) ? Hanko::Digest.file_digest(path) : ''

      if asset_id.empty?
        source
      else
        "#{source}?#{asset_id}"
      end
    end
  end
end
