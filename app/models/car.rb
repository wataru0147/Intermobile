class Car < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :car_manufacturer
  belongs_to :car_model
  has_many :service_transactions

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  validates :plate_number , presence: true, uniqueness: true
  validates :car_model_id, presence: true
  validates :user_id, presence: true
  validates :year, numericality: true, presence: true
  validates :plate_number, format: { with: /[A-Z]{2,3}-[0-9]{3,4}/,
    message: "Follow (XXX-999/XXX-9999/XX-9999)" }


  def self.search(search)
    if search
      where(["plate_number LIKE ?" , "%#{search}%"])
    else
      all
    end    
  end
end
