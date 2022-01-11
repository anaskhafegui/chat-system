module Api
    module V1
        class ChatsController < ApplicationController 
            def index
                chats = Chat.order('created_at DESC');
                render json: {status: 'SUCCESS', message: 'Loaded Chats', data:chats}, status: :ok
            end

            def create
                chat = Chat.new(chat_params)

                if chat.save
                    render json: {status: 'SUCCESS', message: 'Saved Chats', data:chat}, status: :ok
                else 
                    render json: {status: 'Failed', message: 'Chat not saved', data:chat.errors}, status: :unprocessable_entity    
                end
            end    

            private def chat_params

                params.permit(:application_id)

            end
        end
    end
end