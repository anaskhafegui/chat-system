module Api
    module V1
        class ApplicationsController < ApplicationController 
            # authenticate_token by token exepct app index for testing
            before_action :require_login!, except: [:index]
            
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
            
            private 
            
                def application_params
                    params.permit(:name)
                end

                def get_application_by_token
                    return Application.find_by(token: params[:token]);
                end

                def require_login!
                    authenticate_token || render_unauthorized('Access Denied: Unauthorized Access')
                end

                def authenticate_token
                    get_application_by_token
                end  

                def render_unauthorized(message)
                    render json: { status: 'Failed' , message: 'Unauthorized Token' ,data: message}, status: :unprocessable_entity    
                end
        end
    end
end