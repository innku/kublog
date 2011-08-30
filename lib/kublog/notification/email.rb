# This class includes the interface to all the different
# Delivery methods and requires the one that the user chose
# in the configuration File

module Kublog
  module Notification
    module Email
  
      # Sets callbacks for E-mail delivery
      # Includes necessary methods for e-mail notification callback
      # and requires appropriate method of notification (Immediate, Delayed Job..)
      def self.included(base)
        base.send :attr_accessor, :email_notify
        
        base.send :after_save, :notify_email
        base.send :before_validation, :build_email_body, :on => :create
        base.send :before_validation, :really_notify_email?
      
        base.send :include, case Kublog.notification_processing.try(:to_sym)
          when :delayed_job then DelayedJob
          else Immediate
        end
      
        base.send :include, InstanceMethods
      
        # Defines a for_x type of method for each user kind
        # Designed to interface with the user to selectively deliver E-mails
        Kublog.user_kinds.each do |user_kind|
          define_method "for_#{user_kind}?" do
            self.intended_for.include?(user_kind)
          end
        end
      end
    
      module InstanceMethods
        
        # Called to notify users after the creation of a post
        # probably should happen after publication
        def notify_email
          klass = user.class
          if klass.try(:kublog_notifiable) && self.email_notify
            self.email_notify = false
            notifications_sent = 0
            klass.all.each do |user|
              if user.notify_post?(self)
                post_deliver(self, user)
                notifications_sent += 1
              end
            end
            self.update_attribute :users_notified, notifications_sent
          end
        end
        
        protected
      
        # Opens the ERB and Liquid Template set in the mailer view folders
        # sets the context variables and processes them before to remove erb section
        def build_email_body
          if self.email_body.blank? && !Sanitize.clean(self.body).blank?
            template_path = "app/views/kublog/post_mailer/new_post.liquid.html.erb"
            if File.exists?(File.join(Rails.root, template_path))
              template = File.open(File.join(Rails.root, template_path))
            else
              template = File.open(File.join(Engine.root, template_path))
            end
            read_erb_template(template)
          end
        end
        
        def read_erb_template(template)
          post = self
          self.email_body = ERB.new(template.read).result(binding)
        end
        
        def really_notify_email?
          self.email_notify = nil if self.email_notify.to_i.zero?
        end
        
      end
    
      # Queues Process on DJ
      module DelayedJob
        def post_deliver(post, user)
          Delayed::Job.enqueue(EmailJob.new(post, user)) 
        end
      end
  
      # Delivers Immediately
      module Immediate
        def post_deliver(post,user)
          PostMailer.new_post(post, user).deliver
        end
      end
      
    end    
  end
end