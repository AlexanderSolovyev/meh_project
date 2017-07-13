require 'rails_helper'

RSpec.describe Question, type: :model do

  it 'validate presence of title' do
    expect(Question.new(body: '123')).to_not be_valid
  end

  it 'validate presence of body' do
    expect(Question.new(title:'123')).to_not be_valid
  end
end