require 'rails_helper'
feature 'guest and users can read answers for questions' do
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }
  before do
    question
    answer
  end
  scenario 'un-authenticate user can read answers 'do
    visit question_path(question)
    expect(page).to have_content 'MyAnswer'
  end
end