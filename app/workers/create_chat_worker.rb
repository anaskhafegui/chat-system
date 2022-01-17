class CreateChatWorker
  include Sidekiq::Worker
  queue_as :chat
  sidekiq_options retry: false

  def perform(app)
    chat = app.chats.create
    if chat.save
      return chat
    else 
      return chat.errors
    end
  end
end