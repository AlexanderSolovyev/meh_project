require 'rails_helper'
feature 'Only registered user can delete answer' do
  given(:user) { create(:user) }
  given(:question) {create(:question, user: user)}
  given(:answer) {create(:answer, question: question, user: user)}
  before do
    answer
  end
  scenario 'un-authenticate user try delete answer' do
   visit question_path(question)

    expect(page).to_not have_link 'Destroy answer'
  end
  scenario 'user can delete answer', js: true do
    sign_in user
    visit question_path(question)
    click_link 'Destroy answer'

    expect(page).to_not have_content answer.body
  end
end