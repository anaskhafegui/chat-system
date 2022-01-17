module Api
    module V1
        class ApplicationsController < ApplicationController 
            # authenticate_token by token exepct app index for testing
            # require exist chat number 
            def validate_running
                render json: {status: 'SUCCESS', message: 'Chat app runnig successfully', data:nil}, status: :ok
            end

            before_action :require_login!, except: [:index,:create, :validate_running]
            before_action :require_vaild_chat_number!, only: [:create_message_by_application_token_and_chat_number,:show_messages_by_application_token_and_chat_number]
            
            def create
                 application = Application.create(application_params)
                 if application.save
                     render json: ApplicationRepresenter.new(application).as_json, status: :ok
                else 
                    render json: {status: 'Failed', message: 'Application not saved', data:application.errors}, status: :unprocessable_entity    
                end
            end    

            def show_by_token
                render json: ApplicationRepresenter.new(get_application_by_token).as_json, status: :ok   
            end

            def create_chat_by_token
                chat = CreateChatWorker.new.perform(get_application_by_token)
                render json: ChatRepresenter.new(chat).as_json, status: :ok
            end  

            def show_application_chats
                render json: ChatsRepresenter.new(get_application_by_token.chats).as_json, status: :ok
            end

            def create_message_by_application_token_and_chat_number
                Message.__elasticsearch__.import force: true   
                message = CreateMessageWorker.new.perform(get_application_by_token_and_chat_number.messages.create(message_params))
                render json: MessageRepresenter.new(message).as_json, status: :ok
            end 

            def show_messages_by_application_token_and_chat_number 
                #query should be string
                unless params[:query].blank?
                     return search_by_message_text 
                end
                messages = get_application_by_token_and_chat_number.messages
                 if messages
                    render json: MessagesRepresenter.new(messages).as_json, status: :ok
                else 
                    render json: {status: 'Failed', message: 'No Message', data:messages.errors}, status: :unprocessable_entity    
                end
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
                    chat_id = get_application_by_token_and_chat_number.id
                    @results = Message.search( params[:query] , chat_id)
                    @messages = @results.records 
                    render json:MessagesRepresenter.new(@messages).as_json, status: :ok
                end 
        end
    end
end