require "commuter/version"
require "commuter/array"
require "commuter/routing"
require "commuter/util"
require "commuter/dependencies"
require "commuter/controller"
require "commuter/file_model"

module Commuter
	class Application
		def call(env)

			if env['PATH_INFO'] == '/favicon.ico'
				return [404,
					{'Content-Type' => 'text/html'}, []]
			end
			
			klass, act = get_controller_and_action(env)
			controller = klass.new(env)
			text = controller.send(act)
				if controller.get_response
					st, hd, rs = controller.get_response.to_a
					[st, hd [rs.body].flatten]
				else
					[200, 
						{'Content-Type' => 'text/html'},[text]] 
				end
			end

			class Controller
				def initialize(env)
					@env = env 
				end

				def env 
					@env
				end
			end

		end
	end

# module Commuter
#   class Application
#   	def call(env)
#   		`echo debug > debug.txt`;
#   		[200, {'Content-Type' => 'text/html'},
#   			["Hello from Commuter!"]]
#   		end
#   	end
# end
