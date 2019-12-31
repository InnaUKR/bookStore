# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }

  describe 'PUT #update' do
    context 'as a guest' do
      it 'redirect to sign in page' do
        patch :update, params: { id: order.id }
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end

    context 'as a user' do
      before { sign_in user }

      context 'without coupon' do
        before { patch :update, params: { id: order.id } }
        it { expect(response).to redirect_to order_cart_path(order) }
        it { expect(flash[:alert]).to eq(I18n.t('orders.update.unsuccess')) }
      end

      context 'with coupon' do
        let(:coupon) { create(:coupon) }
        before { patch :update, params: { id: order.id, name: coupon.name } }
        it { is_expected.to redirect_to order_cart_path(order) }
        it { expect(flash[:notice]).to eq(I18n.t('orders.update.success')) }
        it { expect(assigns(:order).coupon).to_not be_nil }
      end
    end
  end

  describe 'GET #edit' do
    it 'guest redirects to sign in page' do
      get :edit, params: { id: order.id }
      expect(flash[:alert]).to eq('You are not authorized to access this page.')
    end

    it 'user redirects to checkouts page' do
      sign_in user
      get :edit, params: { id: order.id }
      is_expected.to redirect_to(checkout_path(:address))
    end
  end
end
