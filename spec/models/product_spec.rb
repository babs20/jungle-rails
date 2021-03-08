require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # :NAME TESTS
    describe ':name validation' do
      context 'given a valid name' do
        it 'creates a new product with the given name' do
          @cat1 = Category.create(name: 'Swag')

          @product =
            Product.create(
              name: 'Men\'s Classy shirt',
              description: Faker::Hipster.paragraph(4),
              category_id: @cat1[:id],
              image: 'https://source.unsplash.com/random',
              quantity: 10,
              price: 64.99,
            )

          expect(@product.errors.full_messages.length).to eql(0)
          expect(@product[:name]).to eql('Men\'s Classy shirt')
        end
      end

      context 'given nil for  the name' do
        it 'throws an error' do
          @cat1 = Category.create(name: 'Swag')

          @product =
            Product.create(
              name: nil,
              description: Faker::Hipster.paragraph(4),
              category_id: @cat1[:id],
              image: 'https://source.unsplash.com/random',
              quantity: 10,
              price: 64.99,
            )

          expect(@product.errors.full_messages.length).to eql(1)
          expect(@product.errors.full_messages[0]).to eql(
            'Name can\'t be blank',
          )
        end
      end
    end

    # :PRICE TESTS
    describe ':price validation' do
      context 'given a valid price' do
        it 'creates a new product with the given price' do
          @cat1 = Category.create(name: 'Swag')

          @product =
            Product.create(
              name: 'Men\'s Classy shirt',
              description: Faker::Hipster.paragraph(4),
              category_id: @cat1[:id],
              image: 'https://source.unsplash.com/random',
              quantity: 10,
              price: 64.99,
            )

          expect(@product.errors.full_messages.length).to eql(0)
          expect(@product[:price_cents]).to eql(6499)
        end
      end

      context 'given nil for the price' do
        it 'throws three errors' do
          @cat1 = Category.create(name: 'Swag')

          @product =
            Product.create(
              name: 'Men\'s Classy shirt',
              description: Faker::Hipster.paragraph(4),
              category_id: @cat1[:id],
              image: 'https://source.unsplash.com/random',
              quantity: 10,
              price: nil,
            )

          expect(@product.errors.full_messages.length).to eql(3)
          expect(@product.errors.full_messages[0]).to eql(
            'Price cents is not a number',
          )
          expect(@product.errors.full_messages[1]).to eql(
            'Price is not a number',
          )
          expect(@product.errors.full_messages[2]).to eql(
            'Price can\'t be blank',
          )
        end
      end
    end

    # :QUANTITY TESTS
    describe ':quantity validation' do
      context 'given a valid quantity' do
        it 'creates a new product with the given quantity' do
          @cat1 = Category.create(name: 'Swag')

          @product =
            Product.create(
              name: 'Men\'s Classy shirt',
              description: Faker::Hipster.paragraph(4),
              category_id: @cat1[:id],
              image: 'https://source.unsplash.com/random',
              quantity: 10,
              price: 64.99,
            )

          expect(@product.errors.full_messages.length).to eql(0)
          expect(@product[:quantity]).to eql(10)
        end
      end

      context 'given nil for the quantity' do
        it 'throws an error' do
          @cat1 = Category.create(name: 'Swag')

          @product =
            Product.create(
              name: 'Men\'s Classy shirt',
              description: Faker::Hipster.paragraph(4),
              category_id: @cat1[:id],
              image: 'https://source.unsplash.com/random',
              quantity: nil,
              price: 64.99,
            )

          expect(@product.errors.full_messages.length).to eql(1)
          expect(@product.errors.full_messages[0]).to eql(
            'Quantity can\'t be blank',
          )
        end
      end
    end

    # :CATEGORY TESTS
    describe ':category validation' do
      context 'given a valid category' do
        it 'creates a new product with the given category id' do
          @cat1 = Category.create(name: 'Swag')

          @product =
            Product.create(
              name: 'Men\'s Classy shirt',
              description: Faker::Hipster.paragraph(4),
              category_id: @cat1[:id],
              image: 'https://source.unsplash.com/random',
              quantity: 10,
              price: 64.99,
            )

          expect(@product.errors.full_messages.length).to eql(0)
          expect(@product[:category_id]).to eql(@cat1[:id])
        end
      end

      context 'given nil for the category' do
        it 'throws an error' do
          @cat1 = Category.create(name: 'Swag')

          @product =
            Product.create(
              name: 'Men\'s Classy shirt',
              description: Faker::Hipster.paragraph(4),
              category_id: nil,
              image: 'https://source.unsplash.com/random',
              quantity: 10,
              price: 64.99,
            )

          expect(@product.errors.full_messages.length).to eql(1)
          expect(@product.errors.full_messages[0]).to eql(
            'Category can\'t be blank',
          )
        end
      end
    end
  end
end
