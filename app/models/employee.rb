class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver_id', dependent: :restrict_with_exception,
                         inverse_of: :employee
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver_id', dependent: :restrict_with_exception,
                            inverse_of: :employee
end
