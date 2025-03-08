class CustomFailure < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { success: false, errors: ['Invalid email or password'] }.to_json
  end
end