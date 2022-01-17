class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks


    validates :text, presence: true
    before_create :set_chat_messages_count
    after_create :set_message_number 
    belongs_to :chat
    validates_presence_of :chat 

    def as_json(options={})
        options[:except] ||= [:id]
        super(options)
    end

    
    def as_indexed_json(_options = {})
    as_json(only:[:text,:chat_id])
   end

 
    
    def self.search(query,chat_id)
        __elasticsearch__.search({
            query: { 
          bool: { filter: {
                   term: {"chat_id" => chat_id.to_s}
                },
                must: {
                    query_string: {
                     query: query,
                    fields: ['text']
                    }
                  }
                },
          },
          })
    end 


    def set_chat_messages_count
        self.chat.messages_count += 1
        self.chat.save
    end    

    def set_message_number
        self.message_number = self.chat.messages_count
        self.save
    end
    
end
