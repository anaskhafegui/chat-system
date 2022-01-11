class Chat < ApplicationRecord
    belongs_to :application
    has_many :message, dependent: :destroy
    def as_json(options={})
        options[:except] ||= [:id]
        super(options)
    end 
end
