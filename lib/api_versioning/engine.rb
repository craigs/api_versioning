module ApiVersioning
  class Engine < ::Rails::Engine
    isolate_namespace ApiVersioning

    initializer 'api_versioning.controller' do |app|
      ActiveSupport.on_load(:action_controller) do  
        include ApiVersioning::ActionControllerExtension
      end
    end

  end
end
