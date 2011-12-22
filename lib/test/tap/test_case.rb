require 'yaml'

module Test
  module TAP
    class TestCase

      def initialize(line)
        @tap_line = line
      end

      def run(result)
        dummy, ok, failure, case_name, test_name = /^(ok|not ok) \d+ - ((?:\w+: )?)(\w+)::(.+)$/.match(@tap_line).to_a
        name = "#{sanitize_test_name test_name}(#{case_name})"
        yield(Test::Unit::TestCase::STARTED, name)
        if ok.nil?
          result.add_error( RuntimeError.new @tap_line)
        elsif ok == 'not ok'
          if failure.chomp(': ') == 'Failure'
            # If PHPUnit would return more info, we could fill this out
            result.add_failure(Test::Unit::Failure.new(name, [], failure_message))
          else
            #TODO add_error
          end
        end
        result.add_run
        yield(Test::Unit::TestCase::FINISHED, name)
      end

      def parse_details yaml
        @details = YAML::load( yaml )
      end

      private
      def sanitize_test_name(test_name)
        /(.* with data set #\d+).*/.match(test_name).to_a[1] or test_name
      end

      def failure_message
        return 'Test failed' if @details.nil?
        message = @details["message"]
        if data = @details["data"]
          message += "\nGot: #{data["got"].inspect}"
          message += "\nExpected: #{data["expected"].inspect}"
        end
      end
    end
  end
end
