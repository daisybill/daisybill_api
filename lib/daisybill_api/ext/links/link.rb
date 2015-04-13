module DaisybillApi
  module Ext
    module Links
      class Link
        attr_reader :name, :klass
        attr_accessor :href

        def initialize(name, klass)
          @name = name
          @klass = klass
        end

        def value
          return unless href
          default_path = DaisybillApi::Data::Url::DEFAULT_PATH
          c = DaisybillApi::Data::Client.build(:get, href.gsub(default_path, ''))
          klass.constantize.new(c.response) if c.success?
        end
      end
    end
  end
end
