module Hanko
  module AssetUrlHelper
    URI_REGEXP = ::ActionView::Helpers::AssetUrlHelper::URI_REGEXP

    def asset_path(source, options = {})
      source = source.to_s
      return "" unless source.present?
      return source if source =~ URI_REGEXP

      tail, source = source[/([\?#].+)$/], source.sub(/([\?#].+)$/, '')

      if extname = compute_asset_extname(source, options)
        source = "#{source}#{extname}"
      end

      if source[0] != ?/
        # The patch is only here
        source = compute_asset_path(source, options.merge(fingerprint: tail.nil?))
      end

      relative_url_root = defined?(config.relative_url_root) && config.relative_url_root
      if relative_url_root
        source = File.join(relative_url_root, source) unless source.starts_with?("#{relative_url_root}/")
      end

      if host = compute_asset_host(source, options)
        source = File.join(host, source)
      end

      "#{source}#{tail}"
    end
    alias_method :path_to_asset, :asset_path

    def compute_asset_path(source, options = {})
      fingerprint = options.delete(:fingerprint)

      source = super
      return source unless fingerprint

      asset_id = Hanko::Fingerprint.pon(config.assets_dir, source)
      if asset_id.empty?
        source
      else
        "#{source}?#{asset_id}"
      end
    end
  end
end
