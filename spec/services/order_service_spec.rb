# spec/services/order_service_spec.rb
require 'rails_helper'

RSpec.describe OrderService, type: :service do
  let(:reward) { create(:reward) } # You need to define the factory for Reward
  let(:employee) { create(:employee) } # You need to define the factory for Employee
  let(:order_params) { { city: 'City', postcode: '12345', street: 'Street' } }
  let(:order) { build(:order) } # You need to define the factory for Order
  subject { OrderService.new(order, reward, employee, order_params) }

  describe '#process_order' do
    context 'when delivery method is post_delivery' do
      before do
        allow(reward).to receive(:delivery_method).and_return('post_delivery')
      end

      it 'updates employee address and places order' do
        expect(subject).to receive(:update_employee_address)
        expect(subject).to receive(:place_order)
        expect(subject.process_order).to eq(:success)
      end
    end

    context 'when delivery method is online' do
      before do
        allow(reward).to receive(:delivery_method).and_return('online')
      end

      it 'marks order as delivered, sends email, and updates online code' do
        expect(order).to receive(:status=).with('delivered')
        expect(subject).to receive(:place_order)
        expect(OrderMailer).to receive_message_chain(:with, :mail_with_code, :deliver_now)
        expect(subject).to receive(:update_online_code)
        expect(subject.process_order).to eq(:success)
      end
    end

    context 'when delivery method is invalid' do
      before do
        allow(reward).to receive(:delivery_method).and_return('invalid')
      end

      it 'returns :invalid_delivery_method' do
        expect(subject.process_order).to eq(:invalid_delivery_method)
      end
    end
  end
end
