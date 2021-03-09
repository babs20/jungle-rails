require 'rails_helper'

RSpec.feature 'AddToCarts', type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99,
      )
    end
  end

  scenario 'They see all products' do
    visit root_path
    find_button('Add').click
    sleep(1)

    # commented out b/c it's for debugging only
    save_and_open_screenshot

    expect(page.find('li', text: 'My Cart (1)')).to have_content('My Cart (1)')
  end
end
