module Api
  module ResponseHelper
    def render_success(data)
      render json: { success: true, **data }
    end

    def render_error(errors, status)
      render json: {
        success: false,
        errors: Array(errors)
      }, status: status
    end
  end
end