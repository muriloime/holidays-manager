require 'rails_helper'

feature 'All Users' do
  scenario "log in" do
    user = FactoryGirl.create(:user)
    sign_in user
    expect(page).to have_content 'Callendar of Holidays'
  end

  scenario "see holidays in callendar", js: true do
    user1 = FactoryGirl.create(:user, name:"ciro")
    user2 = FactoryGirl.create(:user, name:"chang")
    holiday1 = FactoryGirl.create(:holiday, user_id: user1.id, start_date: Date.today, end_date: Date.today + 1)
    holiday2 = FactoryGirl.create(:holiday, user_id: user2.id, start_date: Date.today + 2, end_date: Date.today + 3)
    sign_in user1


    expect(page).to have_content "#{user1.name} - #{holiday1.content}"
    expect(page).to have_content "#{user2.name} - #{holiday2.content}"
  end

  scenario "create a holiday" do
    user = FactoryGirl.create(:user)
    sign_in user

    click_on 'Account'
    click_on 'My Holidays'

    expect(page).to have_content "Listing Holidays of #{user.name}"
    click_on 'New Holiday'

    expect(page).to have_content 'New Holiday'
    expect{
    select(Date.today.day, :from => 'holiday_start_date_3i')
    select(Date.today.strftime("%B"), :from => 'holiday_start_date_2i')
    select(Date.today.year, :from => 'holiday_start_date_1i')
    select(Date.today.day, :from => 'holiday_end_date_3i')
    select(Date.today.strftime("%B"), :from => 'holiday_end_date_2i')
    select(Date.today.year, :from => 'holiday_end_date_1i')
    fill_in 'Content', with: 'blabla'
    click_on 'Create Holiday'
    expect(page).to have_content 'Holiday was created with sucess!'
    }.to change(Holiday, :count).by(1)
  end

  scenario "update the password of an user", js: true do
    user = FactoryGirl.create(:user)
    sign_in user

    click_on 'Account'
    click_on 'Change my Password'

    expect(page).to have_content "Change Password of #{user.name}"

    fill_in 'user_password', with: user.password
    fill_in 'user_new_password', with: '123456'
    fill_in 'user_repeat_new_password', with: '123456'
    click_button 'Save User'

    expect(page).to have_content 'The new password was saved in the system'
  end

  scenario "log out", js: true do
    user = FactoryGirl.create(:user)
    sign_in user

    click_on 'Log out'

    expect(page).to have_content "Log in"
  end

end
