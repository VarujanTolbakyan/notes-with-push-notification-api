class Admins::UsersController < Admins::BaseController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /admins/users
  def index
    @users = User.all
    render json: { users: @users, count: @users.count }
  end

  # GET /admins/users/1
  def show
    render json: { user: @user }
  end

  # POST /admins/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: @user, message: 'User successful created' }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /admins/users/1
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