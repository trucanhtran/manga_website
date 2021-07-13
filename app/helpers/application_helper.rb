module ApplicationHelper
  def current_user
    if session[:user_id].present?
      @user = User.find_by(id: session[:user_id])
    else
      nil
    end
  end
end
