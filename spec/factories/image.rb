FactoryGirl.define do
  factory :image do
    sequence(:url) { |n| "http://example.com/#{n}.jpeg" }

    association :campaign, factory: :campaign

    after :build do |image, evaluator|
      image.tags << FactoryGirl.create(:tag, image: image)
    end
  end
end
