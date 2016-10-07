class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username,:full_name, presence: true
  validates :username,  length: { in: 4..20 }

  validates_zipcode :zip,{ country_code: :us }
  validate :us_location

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

         has_many :items
         has_many :comments
         has_many :offers
         has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
         has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"


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
