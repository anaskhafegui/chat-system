class Chat < ApplicationRecord
    before_create :set_application_chats_count
     after_create :set_chat_number 
    belongs_to :application
    has_many :message, dependent: :destroy
    def as_json(options={})
        options[:except] ||= [:id]
        super(options)
    end   

    def set_chat_number
        self.chat_number = self.application.chats_count
        self.save
    end

    def set_application_chats_count
        self.application.chats_count += 1
        self.application.save
    end
end
