# Processes any given task with the method specified in the configuration
# Currently the available processing methods are
# 
# config.notification_processing = :immediate
# config.notification_processing = :delayed_job
# config.notification_processing = :resque
module Kublog 
  module Processor
    
    # Proxy method that calls the configuration specified processor
    def self.work(task, *params)
      self.send(Kublog.notification_processing, task, *params)
    end
    
    private
    
    # Immediately calls perform on the task given (No background processing)
    def self.immediate(task, *params)
      task.perform *params
    end
    
    # Should create a new Job for processing with DeleyedJob
    def self.delayed_job(task, *params)
      task.delay.perform(*params)
    end
    
    def self.resque(task, *params)
      Resque.enqueue(task, *params)
    end

  end
end
