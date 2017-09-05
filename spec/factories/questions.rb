FactoryGirl.define do
  factory :question do
    user
    title 'MyString'
    body 'MyString'
  end

  factory :invalid_question, class: Question do
    title nil
    body nil
  end
end
