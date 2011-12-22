require 'test/tap/test_suite'
require 'test/unit'

module Test
  module PHPUnit

    def phpunit(file, opts={})
      (class << self; self end).instance_eval do
        define_method :suite do
          Test::PHPUnit::TestSuite.new file, opts
        end
      end
    end

    class TestSuite < Test::Unit::TestSuite
      include Test::TAP::TestSuite

      def initialize(php_file, opts={})
        @php_file = php_file
        @php_opt_string = opts.collect { |k,v| "--#{k} '#{v}'" }.join " "
        super 'Dummy'
      end

      def shell_cmd
        "phpunit --tap #{@php_opt_string} #{@php_file}"
      end

    end
  end
end
