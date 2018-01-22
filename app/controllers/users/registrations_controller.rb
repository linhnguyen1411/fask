class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  before_action :check_anonymous

  def update
    if current_user.is_create_by_wsm
      flash[:danger] = t "profile.update_error"
    else
      if resource.update_attributes(user_params)
        flash[:success] = t "profile.update_success"
      else
        flash[:danger] = t "profile.update_error"
      end
    end
    redirect_to edit_user_registration_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def user_params
    if !current_user.is_create_by_wsm
      params.require(:user).permit :name, :avatar
    end
  end

  def check_anonymous
    return if current_user.id != Settings.anonymous_number
    flash[:danger] = t "anonymous_edit_user"
    redirect_to root_path
  end
end
