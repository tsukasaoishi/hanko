module Hanko
  module AssetUrlHelper
    URI_REGEXP = %r{^(?:[-a-z]+://|cid:|data:|//)}i

    def asset_path(source, options = {})
      @_hanko_has_tail = source.match?(/[\?#]/)
      super
    end
    alias_method :path_to_asset, :asset_path

    def compute_asset_path(source, options = {})
      source = super
      return source if @_hanko_has_tail

      asset_id = Hanko::Fingerprint.pon(config.assets_dir, source)
      if asset_id.empty?
        source
      else
        "#{source}?#{asset_id}"
      end
    end
  end
end
