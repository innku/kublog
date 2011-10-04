Kublog.setup do |config|
  
  # Blog name for title and RSS Feed
  config.blog_name = 'Kublog'
  
  config.author_email "Kublog Test <test@kublog.com>"
  
  config.default_url_options = {:host => "www.kublog.com"}
  
  #Delivers Post Notification as soon as created
  config.notification_processing = {:development => :immediate,
                                    :test => :immediate,
                                    :staging => :delayed_job,
                                    :production => :delayed_job }[Rails.env.to_sym]
                                    
  #Types of users in your app to segment notfications
  config.user_kinds = %w(cool semi-cool lame)
  
  # Configure image storage for Image File Uploader
  config.image_storage = {:development => :file, 
                          :test => :file, 
                          :staging => :s3, 
                          :production => :s3}[Rails.env.to_sym]
  #Twitter Sharing Settings
  config.twitter do |twitter|
    twitter.consumer_key = 'xxx'
    twitter.consumer_secret = 'xxx'
    twitter.oauth_token = 'xxx'
    twitter.oauth_token_secret = 'xxx'
  end
  
  # Facebook Sharing Setting
  config.facebook_page_token = 'xxx'
end