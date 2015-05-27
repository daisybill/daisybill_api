module DaisybillApi
  module Ext
    class PageableCollection
      include Enumerable

      def initialize(entries, options = {})
        @entries = entries
        @options = options
      end

      def inspect
        "#<DaisybillApi::Ext::PageableCollection entries: #{entries.to_s[1..80]}..., previous_page: #{previous_page_number}, current_page: #{current_page_number}, next_page: #{next_page_number} >"
      end

      def each(&block)
        entries.each do |entry|
          block.call(entry)
        end
      end

      def first_page
        resource_class.all(default_options)
      end

      def last_page
        resource_class.all(default_options.merge(page: total_page_count))
      end

      def next_page
        if next_page_number
          resource_class.all(default_options.merge(page: next_page_number))
        end
      end

      def previous_page
        if previous_page_number
          resource_class.all(default_options.merge(page: previous_page_number))
        end
      end

      def current_page_number
        retrieve_header_value(:x_page)
      end

      private

      attr_reader :options, :entries

      def default_options
        params.merge(per_page: results_per_page)
      end

      def headers
        @headers ||= options[:headers] || {}
      end

      def params
        @params ||= options[:params] || {}
      end

      def resource_class
        @resource_class ||= options[:resource_class]
      end

      def previous_page_number
        retrieve_header_value(:x_prev_page)
      end

      def next_page_number
        retrieve_header_value(:x_next_page)
      end

      def results_per_page
        headers[:x_per_page]
      end

      def total_page_count
        headers[:x_total_pages]
      end

      def retrieve_header_value(key)
        headers[key].to_s.empty? ? nil : headers[key].to_i
      end
    end
  end
end
