module Api
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    include Api::ResponseHelper
    respond_to :json, :html
    
    def google_oauth2
      handle_auth "Google"
    end
    
    def failure
      redirect_to "/login?auth_error=#{CGI.escape(params[:message] || 'Authentication failed')}"
    end
    
    private
    
    def handle_auth(kind)
      @user = User.from_omniauth(request.env["omniauth.auth"])
      
      if @user.persisted?
        sign_in @user
        
        redirect_to "/auth/callback?success=true"
      else
        session["devise.#{kind.downcase}_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to "/auth/callback?error=#{CGI.escape(@user.errors.full_messages.join(','))}"
      end
    end
  end
end