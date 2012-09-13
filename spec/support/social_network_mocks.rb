module Twitter
  class Client
    def update(status, options={})
      Twitter::Status.new(status)
    end
  end
end

module FbGraph
  module Connections
    module Links
      def link!(options = {})
        nil
      end
    end
  end
end
