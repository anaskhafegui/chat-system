class Message < ApplicationRecord
    belongs_to :chat
    def as_json(options={})
        options[:except] ||= [:id]
        super(options)
    end 
end
