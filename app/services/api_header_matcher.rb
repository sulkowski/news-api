module News
  module Services
    class ApiHeaderMatcher < MethodStruct.new(:accept_header, :vendor, :version, :media_range, method_name: :matches?)
      def matches?
        !accept_header.match(accept_header_regexp).nil?
      end

      private

      def accept_header_regexp
        /\A#{type}\/vnd\.#{vendor}\.v(?<version>(#{version}))\+#{subtype}\z/
      end

      def accept_header
        @accept_header || ''
      end

      def vendor
        @vendor || '.+'
      end

      def version
        @version || '[0-9]*(\.[0-9]+[0-9]*)?'
      end

      def media_range
        @media_range || '.*/.*'
      end

      def type
        media_range.split('/').fetch(0, '.+')
      end

      def subtype
        media_range.split('/').fetch(1, '.+')
      end
    end
  end
end
