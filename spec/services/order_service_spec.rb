require 'rails_helper'

RSpec.describe OrderService, type: :service do
  subject(:order_service) { described_class.new(order, reward, employee, order_params) }

  let(:reward) { create(:reward) }
  let(:employee) { create(:employee) }
  let(:order_params) { { city: 'City', postcode: '12345', street: 'Street' } }
  let(:order) do
     create(:order)
  end
  describe '#process_order' do
    context 'when reward has post delivery method' do
      before do
        allow(reward).to receive(:delivery_method).and_return('post_delivery')
        allow(order_service).to receive(:process_post_delivery)
      end

      it 'calls process_post_delivery' do
        expect(order_service).to receive(:process_post_delivery)
        order_service.process_order
      end
    end

    context 'when reward has online delivery method' do
      before do
        allow(reward).to receive(:delivery_method).and_return('online')
        allow(OrderMailer).to receive(:mail_with_code)
        allow(order).to receive(:status).and_return('delivered')
        allow(order_service).to receive(:process_online_delivery)
      end

      it 'calls process_online_delivery and sets order status to delivered and sends email' do
        expect(order).to have_received(:status).with('delivered')
        expect(order).to have_received(:place_order)
        expect_any_instance_of(OrderMailer).to have_received(:mail_with_code)
        order_service.process_order
      end
    end

    context 'when reward has invalid delivery method' do
      before do
        allow(reward).to receive(:delivery_method).and_return('invalid')
      end

      it 'returns :invalid_delivery_method' do
        expect(order_service.process_order).to eq(:invalid_delivery_method)
      end
    end
  end
end
