class Image < ActiveRecord::Base
  belongs_to :campaign
  has_many :tags, dependent: :destroy
end
