require 'rails_helper'
feature 'all can view questions list' do
  before {create(:question)}
  scenario 'view list of questions' do

    visit questions_path
    expect(page).to have_content "MyString"
  end
end
