class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def update
    if resource.update_attributes user_params
      flash[:success] = t "profile.update_success"
    else
      flash[:danger] = t "profile.update_error"
    end
    redirect_to edit_user_registration_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def user_params
    params.require(:user).permit :name, :avatar
  end
end
