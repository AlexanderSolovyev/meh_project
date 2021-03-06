require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to belong_to :question }
  it {should have_many :attachments}
  it {should accept_nested_attributes_for :attachments}
end
