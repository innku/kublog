module Kublog
  module Notifiable
    class Facebook FbPost
      
      def self.included(base)
        base.send :attr_accessor, :facebook_notify, :facebook_text
        
        base.send :include, InstanceMethods
        
        base.send :include, case Kublog.notification_processing.try(:to_sym)
          when :delayed_job then DelayedJob
          else Immediate
        end
        
        base.send :after_save, :notify_facebook
        base.send :validates_presence_of, :facebook_text, :if => :facebook_notify
        base.send :before_validation, :really_notify_facebook?
      end
      
      module InstanceMethods
        
        protected
        
        def notify_facebook
          if self.facebook_notify
            self.facebook_notify = nil
            wall_post_deliver(:link => self.url, :message => self.facebook_text)
          end
        end
        
        def really_notify_facebook?
          self.facebook_notify = nil if self.facebook_notify.to_i.zero?
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