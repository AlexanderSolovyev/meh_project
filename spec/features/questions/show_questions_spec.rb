require 'rails_helper'
feature 'all can view questions list' do
  given(:question) {create(:question, user: user)}
  given(:user) {create(:user)}
  before {question}
  scenario 'view list of questions' do
    visit questions_path
    expect(page).to have_content 'MyString'
  end
end
