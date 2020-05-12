# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'

module EacLauncher
  module Stereotype
    class << self
      attr_reader :stereotypes

      def included(base)
        @stereotypes ||= []
        @stereotypes << base
        base.extend(ClassMethods)
      end

      def git_stereotypes
        stereotypes.select { |c| c.name.demodulize.downcase.match('git') }
      end

      def nogit_stereotypes
        stereotypes - git_stereotypes
      end
    end

    module ClassMethods
      def stereotype_name
        name.gsub(/^.*::/, '')
      end

      def stereotype_name_in_color
        stereotype_name.send(color)
      end

      def publish_class
        sub_class('Publish')
      end

      def warp_class
        sub_class('Warp')
      end

      private

      def sub_class(sub_class_name)
        klass = const_get(sub_class_name)
        klass.is_a?(Class) ? klass : nil
      rescue NameError
        nil
      end
    end
  end
end
