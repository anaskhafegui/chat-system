class ChatRepresenter
    def initialize(chat)
      @chat = chat
    end
  
    def as_json
    {
      status: 'SUCCESS', 
      message: 'Chat created successfully',
      data:
            {
              app_name: chat.application.name,
              chat_number: chat.chat_number,
              messages_count: chat.messages_count,
              created_at: chat.created_at
            }
    }    
    end
  
    private
    
    attr_reader :chat
  end