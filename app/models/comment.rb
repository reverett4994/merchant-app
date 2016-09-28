class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  validates :user, :presence => true
  validates :item, :presence => true
  validates :content, :presence => true,length: { maximum: 250 }
  validates :content, length: { minimum: 2 }


end
