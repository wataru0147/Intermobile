class User < ActiveRecord::Base	
  



  belongs_to :role
  has_many :service_todos, :foreign_key => :technician_in_charge_id
  has_many :cars,  dependent: :destroy
  has_many :service_transactions, through: :cars
  has_many :comments,  dependent: :destroy
  after_initialize :set_default_role, :if => :new_record?
  has_many :notifications, dependent: :destroy
  validates :email, uniqueness: true
  validates :contact_number_prefix, numericality: true, presence: true
  validates :contact_number, numericality: true, presence: true, length: { is: 7}
  validates :first_name, length: { in: 2..20}
  validates :last_name, length: { in: 2..20}

  scope :admin, -> {where(role_id: 4)}
  scope :technician, -> {where(role_id: 3)}
  scope :staff, -> {where(role_id: 2)}
  scope :user, -> {where(role_id: 1)}

  def set_default_role
  	self.role_id = 1
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


end
