class UsersController < BaseController
  before_action :authenticate_request, except: [:create, :login]
  before_action :set_user, only: [:show, :destroy, :update]
  before_action -> { user_authorization(@user.id) }, only: [:update, :destroy]

  # GET /users/1
  def show
    render json: { user: @user }
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
    @user = User.new(user_params)

    if @user.save && @user.authenticate(user_params[:password])
      render_json_auth_token(user_id: @user.id)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /users/1
  def update
    if @user.update(user_params)
      render json: { user: @user, message: 'User successful updated' }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    render json: { message: 'User successful deleted' }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
