class User < ActiveRecord::Base
  include Kublog::Notifiable
  include Kublog::Author
  
  has_secure_password
  validates_presence_of :email
  validates_presence_of :password
  
  def to_s
    name.titleize
  end
  
  def notify_post?(post)
    true
  end
  
  def admin?
    self.admin
  end
  
end
