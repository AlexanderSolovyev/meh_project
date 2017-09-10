require 'rails_helper'

feature 'Add files to answer', %q{
In order to illustrate my answer
As answer's author
I would like to attach answer
} do

  given(:question) {create(:question, user: user)}
  given(:user) {create(:user)}

  background do
    sign_in user
    visit question_path(question)
  end

  scenario 'User adds file then asks question', js: true do
    within '.answer' do
      fill_in 'answer[body]', with: 'My answer'
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_button 'Send answer'
    end
    within '.answers' do
      expect(page).to have_link 'spec_helper.rb'
    end
  end
end