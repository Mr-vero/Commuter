require_relative "test_helper"


class TestController < Commuter::Controller
	def index
		"Hello!"  # Not rendering a view
	end
end

class TestApp < Commuter::Application
	def get_controller_and_action(env)
        [TestController, "index"]
	end
end

class CommuterAppTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		TestApp.new
	end

	def test_request
		get "/"

		assert last_response.ok?
		body = last_response.body
		assert body["Hello"]
	end
end
