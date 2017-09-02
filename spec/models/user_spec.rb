require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates email' do
    expect(User.new(password: '123')).to_not be_valid
  end

  it 'validate password' do
    expect(User.new(email: 'user@test.com')).to_not be_valid
  end
end
