require 'daisybill_api/ext/links/link'

module DaisybillApi
  module Ext
    module Links
      module ClassMethods
        def link(name, options = {})
          clazz = modulize options[:class]
          links[name] = Link.new name, clazz
          define_method(name) { read_link(name).value }
        end

        def links
          @links ||= {}
        end
      end

      module InstanceMethods
        def initialize(attributes)
          class_links.each { |link| links[link.name] = link.clone }
          self.links = attributes.delete 'links'
          super(attributes)
        end

        def links=(values)
          return if values.nil?
          values.each { |link| write_link link['rel'], link['href'] }
        end

        private

        def read_link(name)
          links[name]
        end

        def write_link(name, href)
          if link = links[name.to_sym]
            link.href = href
          else
            DaisybillApi.logger.debug "Was trying to set unexisting link #{name.inspect} with #{href.inspect}"
          end
        end

        def class_links
          @class_links ||= self.class.links.values
        end

        def links
          @links ||= {}
        end
      end

      def self.included(base)
        base.class_eval do
          include DaisybillApi::Ext::Links::InstanceMethods
          extend DaisybillApi::Ext::Links::ClassMethods
        end
      end
    end
  end
end
