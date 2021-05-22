class BaseController < ApplicationController
  def user_authorization(id)
    return if current_user && current_user.id == id
    render_json_not_access
  end
end