module DaisybillApi
  module Ext

    # Provides a paginated collection of objects that can iterated upon:
    #
    #   bp = DaisybillApi::Models::BillingProvider.find(14) # => <DaisyBillApi::Models::BillingProvider>
    #   patients = bp.patients # => #<DaisybillApi::Ext::PageableCollection>
    #
    #   until patients.next_page.nil? do
    #     puts patients.map(&:id)
    #     patients = patients.next_page
    #   end
    #   # => [1, 2, 3, 4, 5]
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

      # Returns the first page of the collection
      #
      #   @patients = DaisybillApi::Models::Patient.all(billing_provider_id: 25) # => #<DaisybillApi::Ext::PageableCollection>
      #
      #   @patients.first_page # => #<DaisybillApi::Ext::PageableCollection>
      #
      # @return [PageableCollection]
      def first_page
        resource_class.all(default_options)
      end

      # Returns the last page in the collection
      #
      #   @patients.last_page # => #<DaisybillApi::Ext::PageableCollection>
      #
      # @return [PageableCollection]
      def last_page
        resource_class.all(default_options.merge(page: total_page_count))
      end

      # Returns the next page in the collection
      #
      #  @providers.next_page # => #<DaisybillApi::Ext::PageableCollection>
      #
      # @return [PageableCollection, nil]
      def next_page
        if next_page_number
          resource_class.all(default_options.merge(page: next_page_number))
        end
      end

      # Returns the previous page in the collection
      #
      #   @providers.previous_page # => #<DaisybillApi::Ext::PageableCollection>
      #
      # @return [PageableCollection, nil]
      def previous_page
        if previous_page_number
          resource_class.all(default_options.merge(page: previous_page_number))
        end
      end

      # Returns the current page number
      #
      #   @providers.current_page_number # => 1
      #
      # @return [Integer]
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
