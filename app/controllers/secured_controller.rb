class SecuredController < ApplicationController
  require_relative '../../services/authorization_service'
  require_relative '../../lib/json_web_token'

  before_action :authorize_request

  private

  def authorize_request
    authorize_request = AuthorizationService.new(request.headers)
    @current_user = authorize_request.current_user
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
end
