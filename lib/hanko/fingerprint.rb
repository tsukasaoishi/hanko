require 'digest/sha2'

module Hanko
  class Fingerprint
    class << self
      attr_writer :digest_class

      def pon(assets_dir, source)
        cached_pon[source] ||= generate_pon(assets_dir, source)
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
        File.file?(path) ? file_digest(path) : ''
      end

      def file_digest(path)
        digest_class.file(path).hexdigest
      end

      def digest_class
        @digest_class || ::Digest::SHA256
      end
    end
  end
end

