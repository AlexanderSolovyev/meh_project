require 'rails_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As an question's author
  I'd like to able attach files
} do

  given(:user) {create(:user)}

  background do
    sign_in user
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'question[title]', with: 'Test question'
    fill_in 'question[body]', with: 'test test'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_button 'Create'

    expect(page).to have_content 'spec_helper.rb'
  end
end