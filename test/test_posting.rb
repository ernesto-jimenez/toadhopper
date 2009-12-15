require File.expand_path(File.join(File.dirname(__FILE__), 'helper'))

class ToadHopper::Dispatcher::TestPosting < Test::Unit::TestCase
  def test_posting
    dispatcher = ToadHopper::Dispatcher.new("abc123")
    error = begin; raise "Kaboom!"; rescue => e; e end

    response = dispatcher.post!(error)
    assert_equal 422, response.status
    assert_equal ['No project exists with the given API key.'], response.errors
  end

  if ENV['HOPTOAD_API_KEY']
    def test_posting_integration
      dispatcher = ToadHopper::Dispatcher.new(ENV['HOPTOAD_API_KEY'])
      error = begin; raise "Kaboom!"; rescue => e; e end

      response = dispatcher.post!(error)
      assert_equal 200, response.status
      assert_equal [], response.errors
    end
  end
end
