module Api
  class BaseController < ApplicationController
    include Api::ResponseHelper
    include Api::ApiMessages

    protect_from_forgery with: :null_session
    before_action :authenticate_user!

    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error('Resource not found', :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error(e.message, :unprocessable_entity)
    end

    rescue_from StandardError do |e|
      render_error(e.message, :internal_server_error)
    end

    def authenticate_user!
      unless current_user
        render_error('Unauthorized', :unauthorized)
      end
    end
  end
end