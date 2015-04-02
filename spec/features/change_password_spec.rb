require 'rails_helper'

feature 'Change Password' do
  scenario "update the password of a user", js: true do
    user = FactoryGirl.create(:user)
    visit root_path

    expect(page).to have_content 'Log in'
    fill_in 'session_login', with: user.login
    fill_in 'session_password', with: user.password
    #binding.pry
    #save_and_open_file
    click_button 'Log in'

    expect(page).to have_content 'Callendar of Holidays'
    click_on 'Account'
    click_on 'Change my Password'

    expect(page).to have_content 'Change Password of'

    fill_in 'user_password', with: user.password
    fill_in 'user_new_password', with: '123456'
    fill_in 'user_repeat_new_password', with: '123456'
    click_button 'Save User'

    expect(page).to have_content 'The new password was saved in the system'


  end
end
