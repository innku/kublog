module Kublog
  class ImagesController < ApplicationController
    include XhrUpload::FileHelper
    
    before_filter  :set_image_file, :only => :create
    
    def create
      @image = Image.new(params[:image])
      respond_to do |format|
        if @image.save
          format.json { render :json => @image }
        else
          format.json { render :json => @image.errors.messages, :status => :unprocessable_entity }
        end
      end
    end
    
    def update
      @image = Image.find(params[:id])
      respond_to do |format|
        if @image.update_attributes(params[:image])
          format.json { render :json => @image }
        else
          format.json { render :json => @image.errors.messages, :status => :unprocessable_entity }
        end
      end
    end
    
    def destroy
      @image = Image.find(params[:id])
      @image.destroy
      respond_to do |format|
        format.json{ render :json => @image }
      end
    end
    
    private
    
    def set_image_file
      params[:image] ||= {:file => received_file}
    end
    
  end
end
