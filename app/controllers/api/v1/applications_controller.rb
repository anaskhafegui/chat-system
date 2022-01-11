module Api
    module V1
        class ApplicationsController < ApplicationController 
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

            private def application_params

                params.permit(:name)

            end
        end
    end
end