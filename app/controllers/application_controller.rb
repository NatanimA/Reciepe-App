class ApplicationController < ActionController::Base
  def current_user
    @user = User.all.first
  end
end
