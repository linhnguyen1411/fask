class UserSettingsController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def edit; end

  def update
    if current_user.update_attributes setting_params
      change_language
      flash[:success] = t "edit_user.update_settings_success"
    else
      flash[:warning] = t "edit_user.update_settings_fail"
    end
    redirect_to edit_user_setting_path
  end

  private

  def setting_params
    params.require(:user).permit(:language,
      notification_settings: [:comment_post, :comment_answer, :reply_post,
        :up_down_vote_post, :like_comment, :llc_answer, :clip_post, :tag_post,
        :follow_user, :create_post],
      email_settings: [:comments_post, :comment_answer, :reply_post,
        :like_comment, :llc_answer, :clip_post, :tag_post]
    )
  end

  def change_language
    I18n.locale = params[:user][:language].to_sym
    session[:locale] = I18n.locale
  end

  def correct_user
    redirect_to new_user_session_path if current_user != @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
