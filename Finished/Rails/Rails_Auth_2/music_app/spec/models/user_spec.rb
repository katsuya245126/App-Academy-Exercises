require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(email: 'anon@gmail.com', password: 'password') }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { should have_many(:notes) }
  end

  it 'should create password digest when password is given' do
    expect(user.password_digest).not_to be_nil
  end

  describe '#password?' do
    it 'returns true if the password is matching' do
      expect(user.password?('password')).to be(true)
    end

    it 'returns false if the password is wrong' do
      expect(user.password?('not_password')).to be(false)
    end
  end

  describe '#reset_session_token' do
    it 'resets session token' do
      before = user.session_token
      user.reset_session_token!

      expect(user.session_token).not_to eq(before)
    end
  end

  describe '::find_by_credentials' do
    before { user.save! }

    it 'should retrieve the matching user' do
      expect(User.find_by_credentials('anon@gmail.com', 'password')).to eq(user)
    end

    it 'should return nil if the credentials don\'t match' do
      expect(User.find_by_credentials('anon@gmail.com', 'not_password')).to eq(nil)
    end
  end
end
