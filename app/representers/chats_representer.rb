class ChatsRepresenter
    def initialize(chats)
      @chats = chats
    end
  
    def as_json
    {
      status: 'SUCCESS', 
      message: 'Loaded Application Chats',
      data:
          chats.map do |chat|
           {
              app_name: chat.application.name,
              chat_number: chat.chat_number,
              messages_count: chat.messages_count,
              created_at: chat.created_at
           }
          end
    }    
    end
  
    
    private
    
    attr_reader :chats
  end