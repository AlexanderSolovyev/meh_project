require 'rails_helper'
feature 'user can crud answers for questions' do
  given(:user){create(:user)}
  given(:question){ create(:question) }
  given(:answer){ create(:answer, question: question) }
  before { question }
  scenario 'authenticate user can create answer', js: true do
    sign_in user
    visit question_path(question)
    fill_in 'answer[body]', with: 'MyAnswer'
    click_on 'Send answer'

    expect(page).to have_content 'MyAnswer'
  end

  scenario 'un-authenticate user cant create answer', js: true do
    visit question_path(question)

    expect(page).not_to have_content 'You answer'

  end

  scenario 'user cant create invalid answer', js: true do
    sign_in user
    visit question_path(question)
    click_on 'Send answer'

    expect(page).to have_content "Body can't be blank"
  end

  before {answer}
  scenario 'user can edit his answer', js: true do
    sign_in user
    visit question_path(question)
    click_on 'Edit answer'
    within '.answers' do
      fill_in 'answer[body]', with: 'My new answer'
    end
    click_on 'Done'
    
    expect(page).to have_content 'My new answer'
  end

  scenario 'Unauthenticated user try to edit answer'
  scenario 'Authenticated user try to edit other user question'
end
