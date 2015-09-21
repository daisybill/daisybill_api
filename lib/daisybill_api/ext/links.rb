require 'daisybill_api/ext/links/link'

module DaisybillApi
  module Ext
    module Links
      module ClassMethods
        def link(name, options = {})
          clazz = modulize options[:class]
          links[name] = l = Link.new name, clazz, options
          attribute l.foreign_key, :integer if l.foreign_key?
          define_method(name) { read_link(name).value }
        end

        def links
          @links ||= {}
        end
      end

      module InstanceMethods
        def initialize(attributes)
          lnks = attributes.delete 'links'
          super(attributes)
          class_links.each { |link| links[link.name] = link.clone }
          self.links = lnks
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
            self.send("#{link.foreign_key}=", link.foreign_id) if href && link.foreign_key?
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
