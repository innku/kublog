# Module to be included in user that enables him to be
# published in Posts

module Kublog
  module Author
    
    def self.included(base)
      Kublog.author_class = base.name
      base.send :has_many, :posts, :class_name => 'Kublog::Post'
    end
    
  end
end