module ApiVersioning
	module ActionControllerExtension
	
		def self.included(base)
			base.send(:include, InstanceMethods)
		end

		module InstanceMethods

			def api_version
				@api_version ||= detect_api_version
			end

			def detect_api_version
				extract_api_version_from_param || extract_api_version_from_header
			end

			def extract_api_version_from_param
				api_version_filter(params['api_version'])
			end

			def extract_api_version_from_header
				api_version_filter(request.headers["HTTP_X_API_VERSION"])
			end

			def api_version_filter(version)
				return nil if version.nil?
				matches = version.match(Api::BaseApi::API_VERSION_REGEX)
				matches.nil? ? nil : matches[0].to_sym
			end

			def render_json(presenters)

				results = []
				
				begin

	  				presenters.each do |key, value|
  						presenter = Api.const_get("#{key.to_s.camelize}Api").new(api_version)
  						results << presenter.render(value)
  					end
				
					render :json => results.join(','), :callback => params[:callback]				
        
		        rescue NameError => e
					render_api_error "Unknown Presenter", 400, e
        		rescue Exception => e
					render_api_error "Bad API Request", 400, e
        		end

			end

			def render_api_error(message, status=400, exception=nil)
				notify_api_error(exception) unless exception.nil?
				status_code = Rack::Utils.status_code(status)
				status_description = Rack::Utils::HTTP_STATUS_CODES[status_code]
				render :status => status, :json => { status_code: status_code, status_description: status_description, message: message }.to_json
			end

			private
			def notify_api_error(exception)
				unless ExceptionNotifier::Notifier.nil?
					ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver
				end
			end

		end
	end
end