class ApplicationController < ActionController::API
  # Validates the token and user and sets the @current_user scope
  def authenticate_request
    if !payload || !JsonWebToken.valid_payload(payload.first)
      return invalid_authentication
    end

    return if current_user

    invalid_authentication
  end

  # Sets the @current_user with payload user_id
  def current_user
    @current_user ||= User.find_by(id: payload.first['user_id'])
  end

  private

  def render_json_auth_token(payload)
    auth_token = JsonWebToken.encode(payload)
    render json: { auth_token: auth_token }, status: :ok
  end

  def render_json_not_access
    render json: { message: 'You do not have access to this resource' }, status: 403
  end

  # Returns 401 response. To handle invalid requests.
  def invalid_authentication
    render json: {error: 'Invalid Request'}, status: :unauthorized
  end

  # From Authorization header decode the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end
end
