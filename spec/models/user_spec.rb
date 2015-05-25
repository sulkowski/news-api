require 'spec_helper'

describe News::Models::User do
  let(:user_params) { { email: '007@mi6.co.uk', password: 'vesper' } }

  describe 'validations' do
    context 'when email already exists in the database' do
      let!(:user) { User.create(user_params) }

      before { expect(user).to be_valid }

      it 'it is not valid' do
        expect(User.new(user_params)).to_not be_valid
      end
    end

    context 'when `email` is not present' do
      it 'is not valid' do
        user_params[:email] = nil
        expect(User.new(user_params)).to_not be_valid
      end
    end

    context 'when `password` is not present' do
      it 'is not valid' do
        user_params[:password] = nil
        expect(User.new(user_params)).to_not be_valid

        user_params[:password] = String.new
        expect(User.new(user_params)).to_not be_valid
      end
    end
  end

  describe '.authorize' do
    let!(:user) { User.create(user_params) }

    context 'when credentails are valid' do
      it 'returns true' do
        expect(User.authorize(user_params)).to be_truthy
      end
    end

    context 'when credentails are not valid' do
      it 'returns false' do
        user_params[:password] = 'le_chiffre'
        expect(User.authorize(user_params)).to be_falsey
      end
    end
  end

  describe '#password=' do
    let(:user) { User.new }

    context 'when the password returns false ' do
      it 'does not call `BCrypt::Password.create but stores input in `password_hash`' do
        expect(BCrypt::Password).to_not receive(:create)

        user.password = nil
        expect(user.password_hash).to eq(nil)

        user.password = String.new
        expect(user.password_hash).to eq(String.new)
      end
    end

    it 'calls `BCrypt::Password.create` and store its result in `password_hash`' do
      expect(BCrypt::Password).to receive(:create).with('secret_password').and_return('password_hash')
      user.password = 'secret_password'
      expect(user.password_hash).to eq('password_hash')
    end
  end

  describe '#password' do
    context 'when the `password_hash` is not stored' do
      it 'returns nil' do
        user = User.new

        expect(user.password).to be_nil
      end
    end

    context 'when the password_hash is stored' do
      it 'calls constructor of the BCrypt::Password and returns its value' do
        user = User.new(password_hash: 'password_hash')

        expect(BCrypt::Password).to receive(:new).with('password_hash').and_return(:password)
        expect(user.password).to eq(:password)
      end
    end
  end
end
