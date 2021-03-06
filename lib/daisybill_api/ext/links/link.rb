module DaisybillApi
  module Ext
    module Links
      class Link
        attr_accessor :href
        attr_reader :name, :klass

        def initialize(name, klass, options = {})
          @name = name
          @klass = klass
          @options = options
        end

        def value
          return unless href
          default_path = DaisybillApi::Data::Url::DEFAULT_PATH
          c = DaisybillApi::Data::Client.build(:get, href.gsub(default_path, ""))
          klass.constantize.new(c.response) if c.success?
        end

        def foreign_key
          @foreign_key ||= @options.has_key?(:foreign_key) ? @options[:foreign_key] : "#{name}_id"
        end

        def foreign_key?
          !@options.has_key?(:foreign_key) || !!@options[:foreign_key]
        end

        def foreign_id
          href.split("/").last
        end
      end
    end
  end
end
