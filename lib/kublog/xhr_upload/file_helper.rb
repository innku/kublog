module Kublog
  module XhrUpload
    module FileHelper
    
      protected
    
      # Gets the file received throug Rack Environment
      def received_file
        if env['rack.input']
          make_tempfile(env['rack.input'], :filename => env['HTTP_X_FILE_NAME'], :type => env["CONTENT_TYPE"])
        end
      end
    
      # Taken from rack. Follows the example of maca to create a TempFile
      # via XHR Request. Used to asynchronously upload images
      def make_tempfile(input, options = {})
        tempfile  = Tempfile.new('image-upload')
        tempfile.set_encoding(Encoding::BINARY) if tempfile.respond_to?(:set_encoding)
        tempfile.binmode
        buffer = ""
        while input.read(1024 * 4, buffer)
          entire_buffer_written_out = false
          while !entire_buffer_written_out
            written = tempfile.write(buffer)
            entire_buffer_written_out = written == Rack::Utils.bytesize(buffer)
            if !entire_buffer_written_out
              buffer.slice!(0 .. written - 1)
            end
          end
        end
        tempfile.rewind
        {:tempfile => tempfile}.merge(options)
      end
    end
  end
end