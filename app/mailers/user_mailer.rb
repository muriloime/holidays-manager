class UserMailer < ApplicationMailer

  def holiday_notification_admin(admin, holiday)
    @admin = admin
    @holiday = holiday
    mail to: admin.login, subject: "New Holiday Notification"
  end

  def holiday_notification_confirmed(holiday)
    @user = holiday.user
    @holiday = holiday
    mail to: @user.login, subject: "Holiday was Confirmed"
  end

  def holiday_notification_canceled(holiday)
    @user = holiday.user
    @holiday = holiday
    mail to: @user.login, subject: "Holiday was Canceled"
  end

  def welcome(user)
    @user = user
    mail to: @user.login, subject: "Welcome to Holiday Manager"
  end

  def password_reset(user)
    @user = user
    mail to: @user.login, subject: "Your password has been changed"
  end

end
