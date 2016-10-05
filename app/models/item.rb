class Item < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :item_album
  has_many :offers
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, :price, :breed,:gender,:age, presence: true
  validates :name, length: { in: 2..20 }
  validates :age, numericality: true
  validates :price, numericality: true

  validates_zipcode :zip,{ country_code: :us }
  validate :us_location
  attr_accessor :distance


private
  def us_location
    @zip=zip
    @google=GoogleMapsAPI::DistanceMatrix.calculate(['08620'],[@zip],{:units=>'imperial'})
    @location= @google.destination_addresses
    @location= @location[0]
    if @location.end_with? 'USA'
      @good=true
    else
      @good=false
    end

    if @good == false
       errors.add(:zip, " code #{@zip} is invalid")
    end
  end
end
