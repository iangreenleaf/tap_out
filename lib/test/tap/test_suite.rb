require 'test/tap/test_case'
require 'open3'

module Test
  module TAP
    module TestSuite

      def run(result, &progress_block)
        yield(Test::Unit::TestSuite::STARTED, '')
        stdin, phpunit, stderr = Open3.popen3 shell_cmd
        if (err = stderr.read).present?
          puts err
          result.add_error err
        else
          while line = phpunit.gets
            if line =~ /\ATAP version \d+\Z/ || line =~ /\A1..\d+\Z/
              next
            elsif line =~ /\A\s*---\Z/
              yaml_content = line
              yaml_content += line until (line=phpunit.gets) =~ /\A\s*\.\.\.\Z/
              @current_case.parse_details yaml_content
            else
              @current_case.run(result, &progress_block) if @current_case.present?
              @current_case = TestCase.new(line)
            end
          end
          @current_case.run(result, &progress_block)
        end
        yield(Test::Unit::TestSuite::FINISHED, '')
      end

      def size
        # We can't give an accurate count without running phpunit, so punt
        1
      end
    end
  end
end
