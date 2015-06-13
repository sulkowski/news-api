module News
  module Helpers
    module ApiVersioning
      def modify_api_accept_headers(mappings:, vendor:)
        request.accept.map! do |accept_header|
          mappings.each do |mapping|
            mapping.fetch(:versions).each do |api_version|
              if Services::ApiHeaderMatcher[accept_header: accept_header.to_s,
                                            vendor: vendor,
                                            version: api_version,
                                            media_range: mapping.fetch(:mime_type)]
                accept_header = build_accept_entry(mapping.fetch(:mime_type), accept_header.priority.first)
              end
            end
          end
          accept_header
        end
      end

      protected

      def build_accept_entry(mime_type, priority)
        Sinatra::Request::AcceptEntry.new("#{mime_type}; q=#{priority}")
      end
    end
  end
end
