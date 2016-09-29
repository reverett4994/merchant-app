class Item < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :item_album
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  attr_accessor :distance
  private

end
