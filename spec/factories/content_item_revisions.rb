FactoryGirl.define do
  factory :content_item_revision do
    content "MyText"
    content_item_revision nil
    created_by 1
    last_modified_by 1
    change_set nil
  end
end
