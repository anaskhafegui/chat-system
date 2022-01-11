module Api
    module V1
        class MessagesController < ApplicationController 
            def index
                messages = Message.order('created_at DESC');
                render json: {status: 'SUCCESS', message: 'Loaded Messages', data:messages}, status: :ok
            end

            def create
                message = Message.new(message_params)

                if message.save
                    render json: {status: 'SUCCESS', message: 'Saved Messages', data:message}, status: :ok
                else 
                    render json: {status: 'Failed', message: 'Message not saved', data:message.errors}, status: :unprocessable_entity    
                end
            end    

            private def message_params

                params.permit(:chat_id)

            end
        end
    end
end