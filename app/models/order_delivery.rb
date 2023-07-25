class OrderDelivery
  include ActiveModel::Model

  attr_accessor :reward_id, :address_id, :city, :postcode, :street, :employee

  def order
    reward = Reward.find(reward_id)
    address = nil
    ActiveRecord::Base.transaction do
        if reward.post_delivery?
          if address_id.present?
            address = Address.find(address_id)
            address.last_used = Time.current
            address.save!
          else
            address = Address.create!(
              employee: employee,
              city: city,
              postcode: postcode,
              street: street,
              last_used: Time.current
            )
          end
        end
        Order.create!(reward: reward, employee: employee, address_snapshot: address)
      end
      true
      rescue StandardError => e
        errors.add(:base, e.message)
        false
  end
end

