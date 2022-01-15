Rails.application.routes.draw do
  require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

  mount Sidekiq::Web => "/sidekiq"
  # ...


  namespace 'api' do
    namespace 'v1' do
      # applications routes
      get  '/', to: 'applications#report'
    
      scope 'applications' do
          get  '/report', to: 'applications#report'
          get  '/', to: 'applications#index'
          get  '/:token', to: 'applications#show_by_token'
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
