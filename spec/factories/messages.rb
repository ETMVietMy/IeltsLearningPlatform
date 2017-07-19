FactoryGirl.define do
  factory :message do
    sender ""
    subject "MyString"
    content "MyText"
    is_read false
  end
end
