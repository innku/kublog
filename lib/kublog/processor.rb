module Kublog 
  module Processor
    
    def self.work(task)
      self.send Kublog.notification_processing, task
    end
    
    def self.immediate(task)
      task.perform
    end
    
    def self.delayed_job(task)
      Delayed::Job.enqueue(task)
    end
    
    
  end
end