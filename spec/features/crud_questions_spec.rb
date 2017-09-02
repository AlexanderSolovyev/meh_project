require 'rails_helper'
feature 'crud for question' do
  given (:user) { create(:user) }
  given (:question) { create(:question) }
  before { question }
  scenario 'all can read question' do
    visit questions_path
    click_link question.title

    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'authenticate user can edit question' do
    sign_in(user)
    visit questions_path
    click_link question.title

    click_link 'Edit'
    fill_in 'question[title]', with: 'My new title'
    fill_in 'question[body]', with: 'My new body'
    click_button 'Done'

    expect(page).to have_content 'Your question successfully updated.'
  end

  scenario 'authenticate user can delete question' do
    sign_in(user)
    visit questions_path
    click_link question.title
    click_link 'Delete'

    expect(page).to have_content 'Deleted successfully'
  end
end
