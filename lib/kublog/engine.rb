## Sets up the engine with an isolated namespace
module Kublog
  class Engine < Rails::Engine
    isolate_namespace Kublog
  end
end
