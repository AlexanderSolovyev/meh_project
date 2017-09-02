require 'rails_helper'

feature 'User can create question' do
  given(:user) { create(:user) }

  scenario 'authenticate user can create question' do
    sign_in(user)

    visit questions_path
    click_link 'Ask question'
    fill_in 'question[title]', with: 'Test question'

    fill_in 'question[body]', with: 'test test'
    click_button 'Create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non-authrnticate user try to create question.' do
    visit questions_path
    click_link 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
