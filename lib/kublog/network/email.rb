# Sets up email delivery method for the notification model
# Includes validations of non blank email content

module Kublog
  module Network
    module Email
      
      TEMPLATE = "app/views/kublog/post_mailer/new_post.liquid.html.erb"
      
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :extend,  ClassMethods
        base.send :validate, :valid_email_content, :if => :email?
      end
      
      module InstanceMethods 
        
        # Calls appropriate processor to process e-mail sending to the
        # bulk of users
        def deliver_email
          Processor.work(BulkEmail, self.id)
        end  
        
        # Never send e-mail notification by default
        def default_email
          false
        end
        
        # Returns true if notification acts as e-mail
        def email?
          self.kind == 'email'
        end
        
        def delivered
          self.times_delivered ||= 0
          self.update_attribute :times_delivered, (self.times_delivered + 1)
        end
        
        private
        
        def valid_email_content
          errors.add(:content, :email) if self.content.blank?
        end
        
      end
      
      module ClassMethods
        
        # Renders a preview of the e-mail that will be sent to the user
        # so that the Author can edit the content of the e-mail on a Liquid Template
        def email_template(post)
          ERB.new(email_erb_template.read).result(binding)
        end

        private
        
        def email_erb_template
          if File.exists?(File.join(Rails.root, TEMPLATE))
            File.open(File.join(Rails.root, TEMPLATE))
          else
            File.open(File.join(Engine.root, TEMPLATE))
          end
        end
        
      end
      
      class BulkEmail
        @queue = :kublog_notifications
      
        def self.perform(notification_id)
          notification = Kublog::Notification.find(notification_id)
          klass = Kublog.notify_class.constantize

          klass.all.each do |user|
            if !user.respond_to?(:notify_post?) || user.notify_post?(notification.roles)
              Processor.work(SingleEmail, notification.id, user.id)
            end
          end
        end
        
      end
      
      class SingleEmail
        @queue = :kublog_notifications 
        
        def self.perform(notification_id, user_id)
          user = Kublog.notify_class.constantize.find(user_id)
          notification = Kublog::Notification.find(notification_id)
          PostMailer.new_post(notification, user).deliver
          notification.delivered
        end

      end
      
    end
    
     
  end
end
