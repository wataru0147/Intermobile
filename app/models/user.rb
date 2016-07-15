class User < ActiveRecord::Base	
  



  belongs_to :role
  has_many :cars
  has_many :comments
  after_initialize :set_default_role, :if => :new_record?



  def set_default_role
  	self.role_id = 1
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


end
