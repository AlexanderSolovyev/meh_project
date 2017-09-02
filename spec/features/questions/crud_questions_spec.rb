require 'rails_helper'
feature 'crud for question' do
  given (:user) { create(:user) }
  given (:question) { create(:question) }
  before { question }

  describe 'authenticate user' do
    before { sign_in(user) }
    scenario 'authenticate user can edit question' do
      visit questions_path
      click_link question.title

      click_link 'Edit'
      fill_in 'question[title]', with: 'My new title'
      fill_in 'question[body]', with: 'My new body'
      click_button 'Done'

      expect(page).to have_content 'Your question successfully updated.'
    end

    scenario 'authenticate user can delete question' do
      visit questions_path
      click_link question.title
      click_link 'Delete'

      expect(page).to have_content 'Deleted successfully'
    end
  end

  describe 'unauthenticate user' do
    scenario 'all can read question' do
      visit questions_path
      click_link question.title

      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end

    scenario 'guest try edit question' do
      visit questions_path
      click_link question.title

      expect(page).to_not have_link 'Edit'
    end
    scenario 'guest try delete question' do
      visit questions_path
      click_link question.title

      expect(page).to_not have_link 'Delete'
    end
  end
end
