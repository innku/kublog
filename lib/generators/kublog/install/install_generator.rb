module Kublog
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path(Engine.root, __FILE__)
      
      class_option :coffee, :type => :boolean, :default => false, :desc => 'Generates Kublogs coffeescripts'
      
      ## Generates migrations to make all installation in one step
      def generate_migrations
        Dir[File.join(source_paths, 'db', 'migrate', '*.rb')].each do |file|
          migration_filepath = file.match(/\A.+\/(db\/migrate\/.+)\Z/i)[1]
          raw_migration_filename = file.match(/\d+\_(.+)\Z/i)[1]   
          migration_template migration_filepath, "db/migrate/#{raw_migration_filename}" 
        end
      end
      
      ## Generates the controller needed for user integration
      def generate_kublog_controller
        copy_file "app/controllers/kublog/application_controller.rb"
      end
  
      ## Generates all html views to the users app. Does not copy RSS 
      def generate_html_views
        selective_copy 'app/views/kublog/posts/*.html.erb'
      end
      
      ## Generates all email views to the users app
      def generate_email_views
        directory "app/views/kublog/post_mailer"
      end
      
      ## Optionally copies javascript files
      def generate_coffee
        directory "app/assets/javascripts/kublog"
      end
      
      private
      
      def self.next_migration_number(path)
        @seconds = @seconds.nil? ? Time.now.sec : (@seconds.to_i + 1)
        @seconds = "0#{@seconds.to_s}" if @seconds < 10
        Time.now.utc.strftime("%Y%m%d%H%M") + @seconds.to_s
      end
      
      def selective_copy(directory, &block)
        Dir[File.join(source_paths, directory)].each do |filename|
          filepath = filename.to_s.gsub("Engine.root.to_s/", '')
          copy_file filepath
        end
      end
        
    end
  end
end
