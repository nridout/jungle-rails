require 'rails_helper'

RSpec.feature "User clicks the 'Add to Cart' button for a product on homepage", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "their cart increases by one" do
    # ACT
    visit root_path
    first('.product').click_on('Add')
    sleep 5

    # DEBUG
    save_screenshot

    # VERIFY
    within('.navbar') { expect(page).to have_text 'My Cart (1)' }

  end
end
