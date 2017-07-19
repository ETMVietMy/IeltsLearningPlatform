FactoryGirl.define do
  factory :writing do
    task_description "MyText"
    task_type "MyString"
    task nil
    user nil
    teacher_id 1
    status "MyString"
  end
end
