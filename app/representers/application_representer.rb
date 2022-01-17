class ApplicationRepresenter
    def initialize(application)
      @application = application
    end
  
    def as_json
      {
        status: 'SUCCESS', 
        message: 'Application Loaded',
        data: {
            name: application.name,
            token: application.token,
            chats_count: application.chats_count,
            created_at: application.created_at    
           }
      }
    end
  
    private
  
    attr_reader :application
  end