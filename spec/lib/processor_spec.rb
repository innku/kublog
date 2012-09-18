require 'spec_helper'
require 'delayed_job_active_record'

describe Kublog::Processor do
  
  class TestTask
    def perform
      true
    end
  end
  
  describe '.work' do
    
    it 'performs a task immediately if notification processing is immediate' do
      Kublog.notification_processing = :immediate
      Kublog::Processor.work(TestTask.new).should == true
    end
    
    it 'creates a job in delayed job for later processing' do
      Kublog.notification_processing = :delayed_job
      Kublog::Processor.work(TestTask.new).should be_an_instance_of(Delayed::Backend::ActiveRecord::Job)
    end

    after(:all) do
      Kublog.notification_processing = :immediate
    end
    
  end
  
end