require 'rails_helper'
feature 'user can crud answers for questions' do
  given(:user){create(:user)}
  given(:question){ create(:question) }
  before { question }
  scenario 'authenticate user can create answer' do
    sign_in user
    visit question_path(question)
    fill_in 'answer[body]', with: 'MyAnswer'
    click_on 'Send answer'
    save_and_open_page

    expect(page).to have_content 'MyAnswer'
  end
end
