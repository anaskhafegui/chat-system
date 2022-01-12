module Api
    module V1
        class ApplicationsController < ApplicationController 
            # authenticate_token by token exepct app index for testing
            # require exist chat number 
            before_action :require_login!,:require_vaild_chat_number!, except: [:index,:create]
            
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

            def show_message_by_applicatiopn_token_and_chat_number
                message = get_application_by_token_and_chat_number.messages

                if message
                    render json: {status: 'SUCCESS', message: 'Message', data:message}, status: :ok
                else 
                    render json: {status: 'Failed', message: 'No Message', data:message.errors}, status: :unprocessable_entity    
                end
            end    

            private 
            
                def application_params
                    params.permit(:name)
                end

                def get_application_by_token
                    return Application.find_by(token: params[:token]);
                end

                def get_application_by_token_and_chat_number
                    return get_application_by_token.chats.find_by(chat_number: params[:chat_number])
                end    

                def require_login!
                    get_application_by_token || render_unauthorized('Unauthorized Access Token')
                end

                def render_unauthorized(message)
                    render json: { status: 'Failed' , message: 'Access Denied' ,data: message}, status: :unprocessable_entity    
                end

                def message_params
                    params.permit(:chat_id, :text)
                end

                def require_vaild_chat_number!
                    get_application_by_token_and_chat_number || render_unauthorized('Chat Number Doesnt exsist')
                end
        end
    end
end