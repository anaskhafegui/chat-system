class Application < ApplicationRecord
    before_create :generate_token
    has_many :chat, dependent: :destroy

    def as_json(options={})
        options[:except] ||= [:id]
        super(options)
    end    

    protected

    def generate_token
        self.token = loop do
        random_token = SecureRandom.base58(60)
        break random_token unless Application.exists?(token: random_token)
        end
    end

end
