module Kublog
  module Notification
    module FbPost
      
      def self.included(base)
        base.send :include, InstanceMethods
        
        base.send :include, case Kublog.notification_processing.try(:to_sym)
          when :delayed_job then DelayedJob
          else Immediate
        end
        
        base.send :after_create, :notify_facebook
      end
      
      module InstanceMethods
        
        protected
        
        def notify_facebook
          if self.facebook_notify
            wall_post_deliver(:link => self.url, :message => self.facebook_text)
          end
        end
        
      end
      
      module DelayedJob
        def wall_post_deliver(elements={})
          Delayed::Job.enqueue(FbPostJob.new(elements)) 
        end
      end
      
      module Immediate
        def wall_post_deliver(elements={})
          Kublog.facebook_client.link!(elements)
        end
      end
      
    end
  end
end