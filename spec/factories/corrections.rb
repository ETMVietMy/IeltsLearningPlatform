FactoryGirl.define do
  factory :correction do
    teacher_id 1
    writing nil
    body "MyText"
    status "MyString"
    task_achievement 1.5
    coherence_cohesion 1.5
    lexical_resource 1.5
    grammar 1.5
  end
end
