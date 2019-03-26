require 'rails_helper'

RSpec.feature "Visitor clicks on a product on the homepage", type: :feature, js: true do

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

  scenario "they navigate to the product detail page" do
    # ACT
    visit root_path
    first('.product').click_link('Details')
    sleep 5

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_css 'section.products-show'

  end
end
