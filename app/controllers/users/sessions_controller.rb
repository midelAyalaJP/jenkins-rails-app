class Users::SessionsController < Devise::SessionsController
    respond_to :json

    def index    
        if current_user
            render json: { user: current_user, }, status: :ok;
        else
            render json: { message: "unauthorized."}, status: :unauthorized
        end
    end

    private
    def respond_with(resource, _opts = {})
        if current_user.present?
            # log_out_failure
            render json: { message: 'Logged.', user: current_user, }, status: :ok;
        else
            render json: { message: "unauthorized."}, status: :unauthorized
        end
      
    end
    def respond_to_on_destroy
      current_user ?  log_out_failure : log_out_success
    end
   
    def log_out_success
      render json: { message: "Logged out." }, status: :ok
    end
    def log_out_failure
      render json: { message: "Logged out failure."}, status: :unauthorized
    end
end