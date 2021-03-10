require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      cat1 = Category.create! name: 'Apparel'

      @product1 =
        cat1.products.create!(
          {
            name: 'Red Bookshelf',
            description: Faker::Hipster.paragraph(4),
            image: open_asset('furniture3.jpg'),
            quantity: 5,
            price: 2_483.75,
          },
        )
      @product2 =
        cat1.products.create!(
          {
            name: 'Electric Chair',
            description: Faker::Hipster.paragraph(4),
            image: open_asset('furniture2.jpg'),
            quantity: 2,
            price: 987.65,
          },
        )

      # Setup at least one product that will NOT be in the order

      @product3 =
        cat1.products.create!(
          {
            name: 'Swag Chair',
            description: Faker::Hipster.paragraph(4),
            image: open_asset('electronics3.jpg'),
            quantity: 2,
            price: 987.65,
          },
        )
    end

    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order =
        Order.new(
          email: 'test@gmail.com',
          total_cents: 987.65 + 2_483.75,
          stripe_charge_id: 'ch_1IT9NPCp344NE9UqNcVGDzpw', # returned by stripe
        )

      @enhanced_cart = [@product1, @product2]

      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * 1,
      )

      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product2.price,
        total_price: @product2.price * 1,
      )

      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!

      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload

      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1[:quantity]).to eql(4)
      expect(@product2[:quantity]).to eql(1)
    end

    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order =
        Order.new(
          email: 'test@gmail.com',
          total_cents: 987.65 + 2_483.75,
          stripe_charge_id: 'ch_1IT9NPCp344NE9UqNcVGDzpw', # returned by stripe
        )

      @enhanced_cart = [@product1, @product2]

      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * 1,
      )

      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product2.price,
        total_price: @product2.price * 1,
      )

      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!

      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      @product3.reload

      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1[:quantity]).to eql(4)
      expect(@product2[:quantity]).to eql(1)
      expect(@product3[:quantity]).to eql(2)
    end
  end
end
