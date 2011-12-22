require 'test/tap/test_case'

module Test
  module TAP
    module TestSuite

      def run(result, &progress_block)
        yield(Test::Unit::TestSuite::STARTED, '')
        phpunit = IO.popen shell_cmd
        while line = phpunit.gets
          if line =~ /\ATAP version \d+\Z/ || line =~ /\A1..\d+\Z/
            next
          elsif line =~ /\A\s*---\Z/
            yaml_content = line
            yaml_content += line until (line=phpunit.gets) =~ /\A\s*\.\.\.\Z/
            @current_case.parse_details yaml_content
          else
            @current_case.run(result, &progress_block) if ! @current_case.nil?
            @current_case = TestCase.new(line)
          end
        end
        @current_case.run(result, &progress_block)
        yield(Test::Unit::TestSuite::FINISHED, '')
      end

      def size
        # We can't give an accurate count without running phpunit, so punt
        1
      end
    end
  end
end
