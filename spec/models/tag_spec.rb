require "rails_helper"

describe Tag do
  subject { FactoryGirl.build(:tag) }

  it { should belong_to :image }
end
