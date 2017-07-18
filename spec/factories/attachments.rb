FactoryGirl.define do
  factory :attachment do
    attachment "MyString"
    attached_item_id 1
    attached_item_type "MyString"
    content_type "MyString"
  end
end
