# Include module in the model to be referenced as author in the post
# Gives the author an association to every post he has published
module Kublog
  module Author
    
    def self.included(base)
      Kublog.author_class = base.name
      base.send :has_many, :posts, :class_name => 'Kublog::Post'
    end
    
  end
end