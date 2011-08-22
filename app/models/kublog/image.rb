module Kublog
  class Image < ActiveRecord::Base
    
    attr_accessible :file, :alt
    mount_uploader  :file, FileUploader
    
    before_create     { |image| image.alt = file_url.match(/([\w|\b|\s\-]+)\.[png|jpg|gif|jpeg]+/)[1] }
    before_validation :get_dimensions
    
    
    private
    
    def get_dimensions
      self.file_width, self.file_height = `identify -format "%wx %h" #{self.file.path}`.split(/x/)
    end
    
  end
end
