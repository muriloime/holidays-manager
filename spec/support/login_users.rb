module LoginUsers
  def set_user_session(user)
    session[:user_id] = user.id
  end

  def sign_in(user)
    visit root_path
    fill_in 'session_login', with: user.login
    fill_in 'session_password', with: user.password
    #binding.pry
    #save_and_open_file
    click_button 'Log in'
  end
end
