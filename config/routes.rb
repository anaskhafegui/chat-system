Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      # applications routes
      scope 'applications' do
          post '/', to: 'applications#create'
          get '/', to: 'applications#index'
          get ':token', to: 'applications#show_by_token'
          get ':token/chats/:chat_number', to: 'applications#show_message_by_applicatiopn_token_and_chat_number'
          get ':token/chats', to: 'applications#show_application_chats'
          post ':token/chats', to: 'applications#create_chat_by_token'
      end
      resources :chats
      resources :messages
    end
  end
end
