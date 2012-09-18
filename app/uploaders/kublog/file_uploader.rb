# encoding: utf-8

module Kublog
  class FileUploader < CarrierWave::Uploader::Base
    include CarrierWave::RMagick
    storage Kublog.image_storage

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def default_url
      '/assets/kublog/missing_image.png' # + [version_name, "default.png"].compact.join('_')
    end

    version :thumb do
      process :resize_to_limit => [54, 54]
    end
    
    version :small do
      process :resize_to_limit => [140, 140]
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end

  end
end
