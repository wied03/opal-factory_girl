require_relative 'filter_processor'

module Opal
  module FactoryGirl
    module SpecLoader
      def execute_specs
        command_line = "SPEC_OPTS=\"--format Opal::FactoryGirl::ProgressJsonFormatter\" rake opal:spec"
        puts "Running #{command_line}"
        example_info = []
        state = :progress
        IO.popen(command_line).each do |line|
          line.force_encoding 'UTF-8'
          case state
          when :progress
            puts line
          when :example_info
            example_info << line
          end
          state = case line
                  when /BEGIN JSON/
                    :example_info
                  else
                    state
                  end
        end.close
        {
          example_info: example_info,
          success: $?.success?
        }
      end

      def parse_results(results)
        JSON.parse results[:example_info].join("\n")
      end

      def get_ignored_spec_failures
        text_based = FileList['spec/filter/**/*.txt'].map do |filename|
          get_compact_text_expressions filename, wrap_in_regex=true
        end.flatten
        processor = FilterProcessor.new
        FileList['spec/filter/**/*.rb'].exclude('**/sandbox/**/*').each do |filename|
          processor.filename = filename
          contents = File.read filename
          processor.instance_eval contents
        end
        text_based + processor.all_filters
      end

      def get_compact_text_expressions(filename, wrap_in_regex)
        line_num = 0
        File.read(filename).split("\n").map do |line|
          line_num += 1
          {
            exclusion: line,
            filename: filename,
            line_number: line_num
          }
        end.reject do |line|
          exclusion = line[:exclusion]
          exclusion.empty? or exclusion.start_with? '#'
        end.map do |filter|
          wrap_in_regex ? filter.merge({ exclusion: Regexp.new(filter[:exclusion]) }) : filter
        end
      end
    end
  end
end
