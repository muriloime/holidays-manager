class UserMailer < ApplicationMailer

  def holiday_notification_admin(admin, holiday)
    @admin = admin
    @holiday = holiday
    mail to: admin.login, subject: "New Holiday Notification"
  end

  def holiday_notification_status(holiday)
    @user = holiday.user
    @holiday = holiday
    if @holiday.status == "Confirmed"
      mail to: @user.login, subject: "Holiday was Confirmed"
    elsif @holiday.status == "Canceled"
      mail to: @user.login, subject: "Holiday is Canceled"
    else
      mail to: @user.login, subject: "Holiday was Pending"
    end
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
