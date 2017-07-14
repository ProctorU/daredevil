module Daredevil
  class Engine < ::Rails::Engine
    isolate_namespace Daredevil
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
