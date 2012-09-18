## Sets up the engine with an isolated namespace
module Kublog
  class Engine < Rails::Engine
    isolate_namespace Kublog
    
    initializer "kublog.add_middleware" do |app|
      app.middleware.use Kublog::Middleware
    end
  end
end
