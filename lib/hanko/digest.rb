require 'digest/sha2'

module Hanko
  class Digest
    class << self
      attr_writer :digest_class

      def file_digest(path)
        digest_class.file(path).hexdigest
      end

      def digest_class
        @digest_class || ::Digest::SHA256
      end
    end
  end
end
