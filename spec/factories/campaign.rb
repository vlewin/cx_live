FactoryGirl.define do
  factory :campaign do
    sequence(:name) { |n| "Campaign #{n}" }

    factory :campaign_with_images do
      after :build do |campaign, evaluator|
        campaign.images << FactoryGirl.create(:image, campaign: campaign)
      end
    end
  end
end
