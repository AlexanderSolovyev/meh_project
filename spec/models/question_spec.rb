require 'rails_helper'

RSpec.describe Question, type: :model do
  it {is_expected.to validate_presence_of(:body)}
  it {is_expected.to validate_presence_of(:title)}
  it { is_expected.to have_many :answers }
  it {should have_many :attachments}
  it {should accept_nested_attributes_for :attachments}
end
