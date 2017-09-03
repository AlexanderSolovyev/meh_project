require 'rails_helper'
feature 'Only user can edit answers for questions' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }
  before do
    question
    answer
  end
  scenario 'user can edit his answer', js: true do
    sign_in user
    visit question_path(question)
    click_link 'Edit answer'
    within '.answers' do
      fill_in 'answer[body]', with: 'My new answer'
    end
    click_button 'Done'
    expect(page).to have_content 'My new answer'
  end

  scenario 'Unauthenticated user try to edit answer', js: true do
    visit question_path(question)

    expect(page).to_not have_link 'Edit answer'
  end
  scenario 'Authenticated user try to edit other user question'
end
