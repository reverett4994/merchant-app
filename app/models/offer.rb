class Offer < ActiveRecord::Base

  belongs_to :user
  belongs_to :item
  validates :message, length: { in: 5..1000 }


end
