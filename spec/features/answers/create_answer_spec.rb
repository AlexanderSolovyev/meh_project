require 'rails_helper'
feature 'create answer' do
  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}
  given(:user2) {create(:user)}
  scenario 'unathenticated user try create answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Send answer'
  end
  scenario 'user create answer', js: true do
    sign_in user
    visit question_path(question)
    fill_in 'answer[body]', with: 'My personal answer'
    click_button 'Send answer'
    expect(page).to have_content 'My personal answer'
  end
  scenario 'another user create answer', js: true do
    sign_in user2
    visit question_path(question)
    fill_in 'answer[body]', with: 'My personal answer'
    click_button 'Send answer'
    expect(page).to have_content 'My personal answer'
  end
end

