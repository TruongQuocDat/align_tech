require 'rails_helper'

RSpec.describe Admins::DashboardController, type: :controller do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }
  let!(:order_1) { FactoryBot.create(:order, user: user_1, status: Order.statuses[:approved]) }
  let!(:order_2) { FactoryBot.create(:order, user: user_2) }

  describe 'get #index' do
    def do_request(admin, params = {})
      sign_in admin if admin
      get :index, params
    end

    context 'access to index dashboard' do
      before do
        do_request(admin)
      end

      it { expect(response).to render_template :index }
    end

    context 'Filter user exist' do
      before do
        do_request(admin, params: { user_id: user_1.id })
      end

      it { expect(assigns(:orders)).to eq [order_1] }
    end

    context 'Filter no select user' do
      before do
        do_request(admin, params: { user_id: nil })
      end

      it { expect(assigns(:orders)).to match_array([order_1, order_2]) }
    end

    context 'Filter order with status' do
      before do
        do_request(admin, params: { status: Order.statuses[:confirmed] })
      end

      it { expect(assigns(:orders).first).to eq order_2 }
    end

    context 'Filter no select status' do
      before do
        do_request(admin, params: { status: nil })
      end

      it { expect(assigns(:orders)).to match_array([order_1, order_2]) }
    end

    context 'Filter select user and status order' do
      before do
        do_request(admin, params: { user_id: user_1.id, status: Order.statuses[:approved] })
      end

      it { expect(assigns(:orders)).to eq([order_1]) }
    end
  end
end
