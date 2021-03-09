require 'rails_helper'

RSpec.feature 'UserLogins', type: :feature, js: true do
  # SETUP
  before :each do
    @user =
      User.create! first_name: 'Brady',
                   last_name: 'Blair',
                   password: 'password',
                   email: 'user@gmail.com'
  end

  scenario 'They see all products' do
    visit login_path

    fill_in('Email', with: 'user@gmail.com')
    fill_in('Password', with: 'password')
    click_button('Submit')
    sleep(1)

    # commented out b/c it's for debugging only
    # save_and_open_screenshot

    expect(page.find(:xpath, "//a[@href='/logout']")).to have_content('Logout')
  end
end
