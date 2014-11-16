FactoryGirl.define do
  factory :tag do
    sequence(:name) { |n| "tag_#{n}" }
    sequence(:description) { |n| "Tag #{n}" }
    sequence(:value) { |n| "Value #{n}" }

    association :image, factory: :image
  end
end
