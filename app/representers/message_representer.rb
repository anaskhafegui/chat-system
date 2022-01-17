class MessageRepresenter
    def initialize(message)
      @message = message
    end
  
    def as_json  
    {
      status: 'SUCCESS', 
      message: 'Message created successfully',
      data:
       { 
          "app_name": message.chat.application.name,
          "chat_number": message.chat.chat_number,
          "message_number": message.message_number,
          "text": message.text,
          "created_at": message.created_at    
        }
    } 
   end 
    private

    attr_reader :message
  end