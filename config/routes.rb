Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      # applications routes
      scope 'applications' do
          get ':token', to: 'applications#show_by_token'
          post '/', to: 'applications#create'
      end



      resources :chats
      resources :messages
    end
  end
end
