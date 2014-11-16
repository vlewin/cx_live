require "rails_helper"

describe Image do
  subject { FactoryGirl.build(:image) }

  it { should belong_to :campaign }
  it { should have_many :tags }
end
