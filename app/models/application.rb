
class Application < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

      
    validates :name, presence: true

    before_create :generate_token
    has_many :chats, dependent: :destroy

    def as_json(options={})
        options[:except] ||= [:id]
        super(options)
    end

    
    def as_indexed_json(_options = {})
    as_json(only:[:name])
   end

 
    
    def self.search(query)
        __elasticsearch__.search(
        {
            query: {
                multi_match: {
                query: query,
                fields: ['name']
                }
            },
            # more blocks will go IN HERE. Keep reading!
        })
    end 


    protected

    def generate_token
        self.token = loop do
        random_token = SecureRandom.base58(60)
        break random_token unless Application.exists?(token: random_token)
        end
    end

end
