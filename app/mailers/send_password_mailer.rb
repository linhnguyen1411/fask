class SendPasswordMailer < ApplicationMailer
  default from: Settings.from_mail

  def send_password user, password
    @user = user
    @password = password

    mail to: @user.email, subject: t("subject_new_password_mail")
  end
end
