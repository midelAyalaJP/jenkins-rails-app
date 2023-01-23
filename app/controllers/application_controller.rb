class ApplicationController < ActionController::API
    #protect_from_forgery with: :null_session
    before_action :authenticate_user!


    #always json response
    rescue_from Exception do |e|
        #log.error "#{e.message}"
        # print "#{e.message}"
        render json: {error: e.message}, status: :internal_server_error
    end
    
    #Errors
    rescue_from  ActiveRecord::RecordNotFound do |e|
        render json: {error: e.message}, status: :not_found
    end

    # rescue_from  ActiveRecord::RecordInvalid do |e|
    #     render json: {error: e.message}, status: :unprocessable_entity
    # end
end
