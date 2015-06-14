class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Concerns
  include Deletable

  # Model Validation
  validates_presence_of :first_name, :last_name

  # Model Relationships
  has_many :projects, -> { where deleted: false }

  # User Methods

  def name
    "#{first_name} #{last_name}"
  end

end
