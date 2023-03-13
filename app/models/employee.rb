class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver_id', dependent: :destroy,
                         inverse_of: :giver
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver_id', dependent: :destroy,
                            inverse_of: :receiver
  has_many :orders, dependent: :destroy, inverse_of: :employee
  # has_many :rewards, dependent: :destroy, inverse_of: :employee
  def password_required?
    false
  end
  validates :password, presence: { on: :create, message: "can't be blank" }
end
