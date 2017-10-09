class Sessions::SessionsController < Devise::SessionsController
  after_action :set_locate, only: :create
  layout "layout_login", only: :new
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    session[:before_login_url] = request.referer if request.original_url != request.referer
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def set_locate
    I18n.locale = current_user.language
    session[:locale] = I18n.locale
  end
end
