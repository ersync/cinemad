module Api
  class SessionsController < Devise::SessionsController
    include Api::ResponseHelper
    respond_to :json

    skip_before_action :verify_authenticity_token

    def create
      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      render_success(user: UserSerializer.serialize_basic(resource))
    end

    def destroy
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "Logged out successfully" }
        format.json { render_success(message: 'Logged out successfully') }
      end
    end

    def failure
      render_error('Invalid email or password', :unauthorized)
    end

    private

    def auth_options
      { scope: resource_name, recall: "#{controller_path}#failure" }
    end

    def respond_to_on_destroy
      render_success(message: 'Logged out successfully')
    end
  end
end