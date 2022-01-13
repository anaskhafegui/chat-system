Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      # applications routes
      scope 'applications' do
          get  '/', to: 'applications#index'
          get  '/search', to: 'applications#search'
          post '/', to: 'applications#create'

          scope ':token/chats' do
            get  '/', to: 'applications#show_application_chats'
            post '/', to: 'applications#create_chat_by_token'
            get  '/:chat_number/messages', to: 'applications#show_messages_by_application_token_and_chat_number'
            post '/:chat_number/messages', to: 'applications#create_message_by_application_token_and_chat_number'
        end
      end
    end
  end
end
