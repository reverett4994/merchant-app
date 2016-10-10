class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User", primary_key: "id"
  belongs_to :recipient, class_name: "User", primary_key: "id"
  validates :message,  length: { in: 5..150 }

end
