class Admins::BaseController < ApplicationController
  before_action :authenticate_request
  before_action :admin_authorization

  def admin_authorization
    return if current_user && current_user.admin?
    render_json_not_access
  end
end