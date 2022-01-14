class CreateChatWorker
  include Sidekiq::Worker
  queue_as :chat
  sidekiq_options retry: false

  def perform(chat)
    if chat.save
      render json: {status: 'SUCCESS', message: 'Chat was created successfully', data:chat}, status: :ok
    else 
        render json: {status: 'Failed', message: 'Cat not saved', data:chat.errors}, status: :unprocessable_entity   
    end
  end
end