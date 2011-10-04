# TapOut #

A test harness for Test::Unit to parse the Test Anything Protocol.

This means that you can run PHPUnit tests (or others) alongside the rest of
your test suite. They'll report failures the same way, and pick up any
formatting from packages like `redgreen` or `turn`.

## How's it work? ##

    require 'test/phpunit'
    class PHPTest < ActiveSupport::TestCase
      extend Test::PHPUnit
      phpunit "test/phpunit/", :configuration => 'test/phpunit/phpunit.xml.dist'
    end

## What's missing? ##

 * Safe command line execution
 * Tests
 * Anything besides PHPUnit
