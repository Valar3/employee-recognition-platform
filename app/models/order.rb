    require 'csv'

    class Order < ApplicationRecord
      attr_accessor :city, :postcode, :street

      belongs_to :employee
      belongs_to :reward
      validate :check_price
      enum status: { non_delivered: 0, delivered: 1 }
      def place_order(current_employee)
        Order.transaction do
          reward.decrement(:available_rewards, 1)
          reward.save!
          current_employee.decrement(:number_of_earned_points, reward.price)
          current_employee.save!
          save!
        end
      end

      def check_price
        errors.add :base, 'You do not have enough points' if    employee.number_of_earned_points < reward.price
      end

      def self.to_csv
        CSV.generate(col_sep: ';') do |csv|
          csv << attribute_names
          all.find_each do |record|
            csv << record.attributes.values
          end
        end
      end
    end
