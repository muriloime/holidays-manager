require 'rails_helper'

feature 'Users Admin' do
  scenario "See all users", js: true do
    admin = FactoryGirl.create(:admin)
    user = FactoryGirl.create(:user, name: "user", login:"user@user.com")
    sign_in admin

    click_on 'Admin Acess'
    click_on 'Users Settings'

    expect(page).to have_content 'Listing users'
    expect(page).to have_content "#{admin.name}"
    expect(page).to have_content "#{admin.login}"
    expect(page).to have_content "#{user.name}"
    expect(page).to have_content "#{user.login}"
  end

  scenario "See all holidays", js: true do
    admin = FactoryGirl.create(:admin)
    user = FactoryGirl.create(:user, name: "user", login:"user@user.com")
    holiday1 = FactoryGirl.create(:holiday, user_id: admin.id, content: "bla")
    holiday2 = FactoryGirl.create(:holiday, user_id: user.id, content: "bli")
    sign_in admin

    click_on 'Admin Acess'
    click_on 'Holiday Settings'

    expect(page).to have_content 'Listing All Holidays'
    expect(page).to have_content "#{admin.name}"
    expect(page).to have_content "#{user.name}"
    expect(page).to have_content "#{holiday1.content}"
    expect(page).to have_content "#{holiday2.content}"
  end

  scenario "Create a manager user", js: true do
    admin = FactoryGirl.create(:admin)
    sign_in admin

    visit new_admin_user_path

    expect(page).to have_content 'New User'

    expect{
    fill_in 'user_name', with: 'testdsade'
    fill_in 'user_login', with: 'testesas@teste.com'
    choose('user_manager_true')
    click_on 'Create User'
    expect(page).to have_content 'The testdsade was created with sucess!'
    }.to change(User, :count).by(1)
  end

  scenario "Change Status of a Holiday to Confirmed", js: true do
    admin = FactoryGirl.create(:admin)
    user = FactoryGirl.create(:user)
    holiday = FactoryGirl.create(:holiday, user_id: user.id)
    sign_in admin

    visit edit_admin_holiday_path(holiday.id)

    expect(page).to have_content 'Editing Holiday'
    choose('holiday_status_confirmed')
    click_on 'Update Holiday'
    expect(page).to have_content 'The holiday status was changed with sucess!'

    expect(Holiday.find(holiday.id).status).to eq "Confirmed"

  end

end