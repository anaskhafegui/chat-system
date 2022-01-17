class MessagesRepresenter
    def initialize(messages)
      @messages = messages
    end
  
    def as_json  
    {
      status: 'SUCCESS', 
      message: 'Loaded Application Messages',
      data:
       { 
         "total_messages": messages.count,
         "messages":  
               messages.map do |message| 
                {     
                  "app_name": message.chat.application.name,
                  "chat_number": message.chat.chat_number,
                  "message_number": message.message_number,
                  "text": message.text,
                  "created_at": message.created_at    
                } 
                end 
        }
    } 
   end 
    private

    attr_reader :messages
  end