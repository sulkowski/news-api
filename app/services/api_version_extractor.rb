module News
  module Services
    class ApiVersionExtracter < MethodStruct.new(:header, method_name: :extract)
      def extract
        match = header.match(api_version_regexp)
        match[:version].to_f if match
      end

      private

      def api_version_regexp
        /\A.+\/vnd\..+(\.v(?<version>([0-9]+(\.?[0-9]+)?))).*\z/
      end

      def header
        @header || ''
      end
    end
  end
end
