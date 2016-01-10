module Opal
  module FactoryGirl
    module OpalVersionStuff
      def at_least_opal_0_9?
        # it's ok if we have a pre-release version
        Gem::Dependency.new('opal', '>= 0.9').match?('opal', Gem::Version.new(opal_version).release.to_s)
      end
    end

    class FilterProcessor
      attr_reader :all_filters
      attr_accessor :filename

      include OpalVersionStuff

      class GuardCheck
        attr_reader :opal_version

        include Opal::FactoryGirl::OpalVersionStuff

        def initialize(current_filters, opal_version)
          @current_filters = current_filters
          @opal_version = opal_version
        end

        def unless(&block)
          result = instance_eval(&block)
          remove_filter if result
        end

        def if(&block)
          result = instance_eval(&block)
          remove_filter unless result
        end

        private

        def remove_filter
          @current_filters.pop
          nil
        end
      end

      def initialize
        @all_filters = []
        @current_title = nil
        @current_filters = []
      end

      def fg_filter(title)
        @current_filters = []
        @current_title = title
        yield
        @all_filters += @current_filters.map do |filter|
          filter.merge({title: @current_title})
        end
      end

      def filter(value)
        call_info = caller[0]
        line_number = /.*:(\d+)/.match(call_info).captures[0]
        @current_filters << {
            filename: filename,
            line_number: line_number,
            exclusion: value
        }
        GuardCheck.new(@current_filters, opal_version)
      end

      private

      def opal_version
        Opal::VERSION
      end
    end
  end
end
