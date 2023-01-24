class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
<<<<<<< Updated upstream
<<<<<<< HEAD
  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver_id'
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver_id'
=======
>>>>>>> c2b5774... set root route, setup devise gem, added a navbar feature,added home button, added seeding
=======
  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver_id'#, dependent: :kudo
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver_id'#, dependent: :kudo
>>>>>>> Stashed changes
end
