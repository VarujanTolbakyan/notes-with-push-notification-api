class UsersController < BaseController
  before_action :authenticate_request, except: [:create, :login]

  # GET /users/1
  def show
    render json: { user: current_user }
  end

  # POST /users/login
  def login
    user = User.find_by(email: user_params[:email])

    if user&.authenticate(user_params[:password])
      render_json_auth_token(user_id: user.id)
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # POST /users
  def create
    user = User.new(user_params)

    if user.save && user.authenticate(user_params[:password])
      render_json_auth_token(user_id: user.id)
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /users/1
  def update
    user = current_user

    if user.update(user_params)
      render json: { user: user, message: 'User successful updated' }
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    current_user.destroy
    render json: { message: 'User successful deleted' }
  end

  def add_device_info
    current_user.add_device_info(device_info_params)
    render json: { message: 'Added device info' }
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

  def device_info_params
    { device_type: find_device_type, device_token: params[:device_token] }
  end
end
