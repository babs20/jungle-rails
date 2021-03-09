require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # has_secure_password TESTS
    describe 'has_secure_password && :password validation' do
      context 'given a valid user password and password confirmation' do
        it 'creates a new user with the given params' do
          @user =
            User.create(
              first_name: 'Brady',
              last_name: 'Blair',
              email: 'test@gmail.com',
              password: 'password',
              password_confirmation: 'password',
            )

          expect(@user.errors.full_messages.length).to eql(0)
          expect(@user[:password_digest]).to_not eql(nil)
        end
      end

      context 'given nil for both password fields' do
        it 'throws an error' do
          @user =
            User.create(
              first_name: 'Brady',
              last_name: 'Blair',
              email: 'test@gmail.com',
              password: nil,
              password_confirmation: nil,
            )
          expect(@user.errors.full_messages.length).to eql(2)
          expect(@user.errors.full_messages[0]).to eql(
            'Password can\'t be blank',
          )
          expect(@user.errors.full_messages[1]).to eql(
            'Password is too short (minimum is 8 characters)',
          )
        end
      end

      context 'given non-matching password fields' do
        it 'throws an error' do
          @user =
            User.create(
              first_name: 'Brady',
              last_name: 'Blair',
              email: 'test@gmail.com',
              password: 'password',
              password_confirmation: 'passwordsss',
            )
          expect(@user.errors.full_messages.length).to eql(1)
          expect(@user.errors.full_messages[0]).to eql(
            'Password confirmation doesn\'t match Password',
          )
        end
      end
    end

    # email TESTS
    describe 'email validation' do
      context 'given a valid user email' do
        it 'creates a new user with the given params' do
          @user =
            User.create(
              first_name: 'Brady',
              last_name: 'Blair',
              email: 'test@gmail.com',
              password: 'password',
              password_confirmation: 'password',
            )

          expect(@user.errors.full_messages.length).to eql(0)
          expect(@user[:email]).to eql('test@gmail.com')
        end
      end

      context 'given nil for email field' do
        it 'throws an error' do
          @user =
            User.create(
              first_name: 'Brady',
              last_name: 'Blair',
              email: nil,
              password: 'password',
              password_confirmation: 'password',
            )
          expect(@user.errors.full_messages.length).to eql(1)
          expect(@user.errors.full_messages[0]).to eql('Email can\'t be blank')
        end
      end

      context 'given a non-unique email' do
        it 'throws an error' do
          @user =
            User.create(
              first_name: 'Brady',
              last_name: 'Blair',
              email: 'test@gmail.com',
              password: 'password',
              password_confirmation: 'password',
            )

          @user2 =
            User.create(
              first_name: 'Brady',
              last_name: 'Blair',
              email: 'test@GMAIL.com',
              password: 'password',
              password_confirmation: 'password',
            )

          expect(@user2.errors.full_messages.length).to eql(1)
          expect(@user2.errors.full_messages[0]).to eql(
            'Email has already been taken',
          )
        end
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context 'given correct email and password pair' do
      it 'returns the user object' do
        @user =
          User.create(
            first_name: 'Brady',
            last_name: 'Blair',
            email: 'test@gmail.com',
            password: 'password',
            password_confirmation: 'password',
          )

        @user_info =
          User.authenticate_with_credentials('test@gmail.com', 'password')

        expect(@user_info).to_not eql(nil)
        expect(@user_info).to eql(@user)
      end
    end

    context 'given incorrect email and password pair' do
      it 'returns nil' do
        @user =
          User.create(
            first_name: 'Brady',
            last_name: 'Blair',
            email: 'test@gmail.com',
            password: 'password',
            password_confirmation: 'password',
          )

        @user_info =
          User.authenticate_with_credentials('epic@gmail.com', 'password')

        expect(@user_info).to eql(nil)
      end
    end

    context 'given email with whitespace' do
      it 'returns the user object' do
        @user =
          User.create(
            first_name: 'Brady',
            last_name: 'Blair',
            email: 'test@gmail.com',
            password: 'password',
            password_confirmation: 'password',
          )

        @user_info =
          User.authenticate_with_credentials('  test@gmail.com   ', 'password')

        expect(@user_info).to_not eql(nil)
        expect(@user_info).to eql(@user)
      end
    end

    context 'given email with whitespace' do
      it 'returns the user object' do
        @user =
          User.create(
            first_name: 'Brady',
            last_name: 'Blair',
            email: 'test@GMAIL.com',
            password: 'password',
            password_confirmation: 'password',
          )

        @user_info =
          User.authenticate_with_credentials('tEst@gmaiL.com', 'password')

        expect(@user_info).to_not eql(nil)
        expect(@user_info).to eql(@user)
      end
    end
  end
end
