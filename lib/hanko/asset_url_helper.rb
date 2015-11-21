module Hanko
  module AssetUrlHelper
    URI_REGEXP = %r{^(?:[-a-z]+://|cid:|data:|//)}i

    def asset_path(source, options = {})
      source = source.to_s
      return "" if source.empty?
      return source if URI_REGEXP === source

      if index = source.index(/[?#]/)
        source, tail = source[0, index], source[index..-1]
      end

      if extname = compute_asset_extname(source, options)
        source = "#{source}#{extname}"
      end

      if source[0] != ?/
        options[:fingerprint] = !tail
        source = compute_asset_path(source, options)
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
