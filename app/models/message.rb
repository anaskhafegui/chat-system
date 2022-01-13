class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    validates :text, presence: true
    before_create :set_chat_messages_count
    after_create :set_message_number 
    belongs_to :chat
    validates_presence_of :chat 

    def as_json(options={})
        options[:except] ||= [:id, :chat_id]
        super(options)
    end

    
    def as_indexed_json(_options = {})
    as_json(only:[:text])
   end

 
    
    def self.search(query)
        __elasticsearch__.search(
        {
            query: {
                multi_match: {
                query: query,
                fields: ['text']
                }
            },
            # more blocks will go IN HERE. Keep reading!
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
