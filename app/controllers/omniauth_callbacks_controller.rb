class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def create
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)

    if @user.persisted?
      set_flash_message(:notice, :success, kind: auth.provider) if is_navigational_format?
      sign_in_and_redirect @user
      I18n.locale = current_user.language
      session[:locale] = I18n.locale
    else
      flash[:notice] = t "auth_fail"
      redirect_to root_path
    end
  end

  alias_method :framgia, :create
end
