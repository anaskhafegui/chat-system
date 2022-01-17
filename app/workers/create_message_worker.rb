class CreateMessageWorker
    include Sidekiq::Worker
    queue_as :messages
    sidekiq_options retry: false

    def perform(message)
      if message.save
        return message
      else 
        return message.errors
      end        
  end
  
end