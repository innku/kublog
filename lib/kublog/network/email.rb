# This class includes the interface to all the different
# Delivery methods and requires the one that the user chose
# in the configuration File

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
        
        def deliver_email
          Processor.work(BulkEmail.new(self))
        end  
        
        def kublog_email?(role)
          roles.include?(role)
        end
        
        def default_email
          false
        end
        
        def email?
          self.kind == 'email'
        end
        
        private
        
        def valid_email_content
          errors.add(:content, :email) if self.content.blank?
        end
        
      end
      
      module ClassMethods
        
        def email_template(post)
          ERB.new(email_erb_template.read).result(binding)
        end

        def email_erb_template
          if File.exists?(File.join(Rails.root, TEMPLATE))
            File.open(File.join(Rails.root, TEMPLATE))
          else
            File.open(File.join(Engine.root, TEMPLATE))
          end
        end
        
      end
      
      class BulkEmail
        
        def initialize(notification)
          @notification = notification
          @post = notification.post
        end
      
        def perform
          klass = eval(Kublog.notify_class)        
          klass.all.each do |user|
            if user.notify_post?(@post)
              Processor.work(SingleEmail.new(@notification, user))
            end
          end
        end
        
      end
      
      class SingleEmail
        
        attr_accessor :subject, :body, :post, :url
        
        def initialize(notification, user)
          @subject = notification.title
          @body = notification.content
          @post = notification.post
          @url =  notification.url
          @user = user
        end   
        
        def perform
          PostMailer.new_post(self, @user).deliver
        end
        
      end
      
    end
    
     
  end
end