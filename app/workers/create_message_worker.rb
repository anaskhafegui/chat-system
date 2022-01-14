class CreateMessageWorker
    include Sidekiq::Worker
    queue_as :messages
    sidekiq_options retry: false

    def perform(chat)
      if message.save
        render json: {status: 'SUCCESS', message: 'Message was created successfully', data:message}, status: :ok
      else 
        render json: {status: 'Failed', message: 'Message not saved', data:message.errors}, status: :unprocessable_entity   
      end        
  end
  
end