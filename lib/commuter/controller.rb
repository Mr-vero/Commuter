require "erubis"
require "commuter/file_model"
require "rack/request"

module Commuter
	class Controller

		# To pass this to the app controllers folder so we can use filemodl instead of Commuter::Model::FileModel
		include Commuter::Model

		def initialize(env)
			@env = env
		end

		def env
			@env
		end

		def request
			@request ||= Rack::Request.new(@env)
		end

		def params
			request.params
		end

		def response(text, status = 200, headers = {})
			raise "Aye, hello there" if @response
			a = [text].flatten
			@response = Rack::response.new(a, status, headers)
		end

		def get_response
			@response			
		end

		def render_response(*args)
			response(render(*args))
		end

		def render(view_name, locals ={})
			filename = File.join "app","views", "#{view_name}.html.erb"
			template = File.read filename
			eruby = Erubis::Eruby.new(template)
			eruby.result locals.merge(:env => env)
		end

		def controller_name
			klass = self.class
			klass = klass.to_s.gsub /Controller$/, ""
			Commuter.to_underscore klass
		end
	end
end
