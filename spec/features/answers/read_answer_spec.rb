require 'rails_helper'
feature 'guest and users can read answers for questions' do
  given(:answer) {create(:answer, question: question, user: user)}
  given(:question) {create(:question, user: user)}
  given(:user) {create(:user)}
  before do
    answer
  end
  scenario 'un-authenticate user can read answers 'do
    visit question_path(question)
    expect(page).to have_content 'MyAnswer'
  end
end