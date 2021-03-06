require 'rails_helper'
feature 'crud for question' do
  given (:user) { create(:user) }
  given (:user2) {create(:user)}
  given (:question) {create(:question, user: user)}

  describe 'authenticate user' do
    before do
      question
      sign_in(user)
      visit questions_path
      click_link question.title
    end
    scenario 'can edit question', js: true do
      click_link 'Edit'
      fill_in 'question[title]', with: 'My new title'
      fill_in 'question[body]', with: 'My new body'
      click_button 'Done'

      expect(page).to (have_content 'My new title').and(have_content('My new body'))
    end

    scenario 'can delete question' do
      click_link 'Delete'

      expect(page).to have_content 'Deleted successfully'
    end
  end
  describe 'another user' do
    before do
      question
      sign_in(user2)
      visit questions_path
      click_link question.title
    end
    scenario 'try edit other user question' do
      expect(page).to_not have_link 'Edit'
    end

    scenario 'try delete other user question' do
      expect(page).to_not have_link 'Edit'
    end
  end

  describe 'unauthenticate user' do
    before do
      question
      visit questions_path
      click_link question.title
    end
    scenario 'all can read question' do
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end

    scenario 'guest try edit question' do
      expect(page).to_not have_link 'Edit'
    end
    scenario 'guest try delete question' do
      expect(page).to_not have_link 'Delete'
    end
  end
end
