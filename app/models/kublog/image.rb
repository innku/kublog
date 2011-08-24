module Kublog
  class Image < ActiveRecord::Base
    
    validates_presence_of :file
    
    mount_uploader  :file, FileUploader
    attr_accessible :file, :alt
    
    before_create     :set_default_alt
    before_validation :get_dimensions
    
    private
    
    def set_default_alt
      self.alt = file_url.match(/([\w|\b|\s\-]+)\.[png|jpg|gif|jpeg]+/)[1]
    end
    
    def get_dimensions
      self.file_width, self.file_height = `identify -format "%wx %h" #{self.file.path}`.split(/x/)
    end
    
  end
end
