class ApplicationService   
  #begin def initialize(token:) @token = token end 

  

  def self.create_application(application_params)
      application =  Application.create(application_params) 
      return application
  end


  def self.get_application_by_token(token)
    application = Application.find_by(token: token)
  end

  def self.get_application_by_token_and_chat_number(token,chat_number)
      return self.get_application_by_token(token).chats.find_by(chat_number: chat_number)
  end  

end