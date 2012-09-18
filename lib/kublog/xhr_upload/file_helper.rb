module Kublog
  module XhrUpload
    module FileHelper
    
      protected
    
      def received_file
        if env['rack.input']
          { :tempfile => env['rack.input'], :filename => env['HTTP_X_FILE_NAME'], :type => env["CONTENT_TYPE"] }
        end
      end
    
    end
  end
end