class UserMailer < ApplicationMailer

  def holiday_notification(admin,holiday)
    @admin = admin
    @holiday = holiday
    mail to: admin.email, subject: "New Holiday Notification"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
