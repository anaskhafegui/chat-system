module Api
    module V1
        class ApplicationsController < ApplicationController 
            # authenticate_token by token exepct app index for testing
            # require exist chat number 
            before_action :require_login!, except: [:index,:create]
            before_action :require_vaild_chat_number!, only: [:create_message_by_application_token_and_chat_number,:show_messages_by_application_token_and_chat_number]
     
            def create
                 application = Application.create(application_params)
                 if application.save
                    render json: {status: 'SUCCESS', message: 'Application was created successfully', data:application}, status: :ok
                else 
                    render json: {status: 'Failed', message: 'Application not saved', data:application.errors}, status: :unprocessable_entity    
                end
            end    

            def show_by_token
                application = get_application_by_token
                render json: {status: 'SUCCESS', message: 'Loaded Application',data: application }, status: :ok
            end

            def create_chat_by_token
                CreateChatWorker.perform_async(get_application_by_token.chats.create)
                render json: {status: 'SUCCESS', message: 'Chat was created successfully' }, status: :ok
            end  

            def show_application_chats
                chats = get_application_by_token.chats;
                render json: {status: 'SUCCESS', message: 'Loaded Application Chats', data:chats }, status: :ok
            end

            def create_message_by_application_token_and_chat_number
                # Message.__elasticsearch__.import force: true   
                CreateMessageWorker.perform_async(get_application_by_token_and_chat_number.messages.create(message_params))
                render json: {status: 'SUCCESS', message: 'Message was created successfully'}, status: :ok
            end 

            def show_messages_by_application_token_and_chat_number 
                unless params[:query].blank?
                     return search_by_message_text 
                end
                messages = get_application_by_token_and_chat_number.messages
                total = get_application_by_token_and_chat_number.messages.count
                data = {
                        "messages":       messages,
                        "total_messages":  total 
                    }
                 if messages
                    render json: {status: 'SUCCESS', message: 'Message', data:data}, status: :ok
                else 
                    render json: {status: 'Failed', message: 'No Message', data:messages.errors}, status: :unprocessable_entity    
                end
            end    
            
            
            def index
                applications = Application.order('created_at DESC')
                render json: {status: 'SUCCESS', message: 'Loaded Applications', data:applications}, status: :ok
            end

            private 
            
                def application_params
                    params.permit(:name)
                end

                def get_application_by_token
                    return Application.find_by(token: params[:token])
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
                
                def search_by_message_text
                    @results = Message.search( params[:query] )
                    @records = @results.records 
                    @total = @results.count 
                    data = {
                        "messages":       @records,
                        "total_messages":  @total 
                    }
                    render json: {status: 'SUCCESS', message: 'Application ', data: data  }, status: :ok
                end 
        end
    end
end