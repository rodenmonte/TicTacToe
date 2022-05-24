module Tester
  class TestCaseFailure < StandardError
  end

  SUCCESS = 0
  FAILURE = 1

  def tests(&block)
    @test_results = []
    block.call
    successes = @test_results.count { |res| res == SUCCESS }
    failures = @test_results.count { |res| res == FAILURE }
    puts "\nTest suite finished with #{successes} successes and #{failures} failures."
  end

  def test_case(description, &block)
    begin
      block.call
      print "."
      @test_results << SUCCESS
    rescue ::Tester::TestCaseFailure => _e
      puts "Test \"#{description}\" failed"
      @test_results << FAILURE
    end
  end

  def assert_equal?(actual, expected)
    raise ::Tester::TestCaseFailure unless actual == expected
    true
  end

  def assert_not_equal?(actual, expected)
    raise ::Tester::TestCaseFailure unless actual != expected
    true
  end
end

