require 'digest/sha2'

module Hanko
  class Fingerprint
    class << self
      attr_writer :cachable, :prefix, :suffix

      def pon(assets_dir, source)
        if cachable?
          cached_pon[source] ||= generate_pon(assets_dir, source)
        else
          generate_pon(assets_dir, source)
        end
      end

      def digest_class=(klass)
        @cached_pon = {}
        @digest_class = klass
      end

      private

      def cached_pon
        @cached_pon ||= {}
      end

      def generate_pon(assets_dir, source)
        path = File.join(assets_dir || '', source)
        return '' unless File.file?(path)
        fp = file_digest(path)
        fp = "#{prefix}#{fp}" if prefix
        fp = "#{fp}#{suffix}" if suffix
        fp
      end

      def file_digest(path)
        digest_class.file(path).hexdigest
      end

      def digest_class
        return @digest_class if defined?(@digest_class)
        ::Digest::SHA256
      end

      def cachable?
        return @cachable if defined?(@cachable)
        true
      end

      def prefix
        @prefix if defined?(@prefix)
      end

      def suffix
        @suffix if defined?(@suffix)
      end
    end
  end
end

