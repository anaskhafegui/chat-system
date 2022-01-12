module Api
    module V1
        class ApplicationsController < ApplicationController 
            before_action :authorization

            def authorization!
                authenticate_with_http_token do |token, options|
                  @current_user = User.find_by(:auth_token => token)
                end
            
                unless @user.present?
                  # You could return anything you want if the response if it's unauthorized. in this
                  # case I'll just return a json object 
                  return render json: {
                    status: 300,
                    message: "Unauthorized access in the API"
                  }, status: 401
                end
              end
            end
            
            def index
                applications = Application.order('created_at DESC');
                render json: {status: 'SUCCESS', message: 'Loaded Applications', data:applications}, status: :ok
            end

            def create
                application = Application.new(application_params)

                if application.save
                    render json: {status: 'SUCCESS', message: 'Saved Applications', data:application}, status: :ok
                else 
                    render json: {status: 'Failed', message: 'Application not saved', data:application.errors}, status: :unprocessable_entity    
                end
            end    

            def create_chat_by_token
                chats = get_application_by_token.chats.create()
                render json: {status: 'SUCCESS', message: 'Saved Chats', data:chats}, status: :ok
            end  

            def show_by_token
                application = get_application_by_token;
                render json: {status: 'SUCCESS', message: 'Loaded Application', data:application}, status: :ok
            end
            
            def show_application_chats
                chats = get_application_by_token.chats;
                render json: {status: 'SUCCESS', message: 'Loaded Application Chats', data:chats }, status: :ok
            end
            

            private def application_params
                params.permit(:name)
            end

            private def get_application_by_token
                return Application.find_by(token: params[:token]);
            end
        end
    end
end