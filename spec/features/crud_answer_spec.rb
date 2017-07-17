require 'rails_helper'
feature 'user can crud answers for questions' do
  given(:user){create(:user)}
  given(:question){ create(:question) }
  before { question }
  scenario 'authenticate user can create answer', js: true do
    sign_in user
    visit question_path(question)
    fill_in 'answer[body]', with: 'MyAnswer'
    click_on 'Send answer'

    expect(page).to have_content 'MyAnswer'
  end
end
