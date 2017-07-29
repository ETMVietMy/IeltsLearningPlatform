FactoryGirl.define do
  factory :transaction do
    from_account ""
    to_account ""
    amount 1
    transaction_description "MyString"
    tranaction_type nil
  end
end
