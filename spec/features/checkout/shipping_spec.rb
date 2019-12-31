# frozen_string_literal: true

require 'rails_helper'

feature 'At the Checkout page, the Delivery tab' do
  given!(:delivery) { create(:delivery) }
  given(:line_item) { create(:line_item, order: create(:order, :delivery)) }

  scenario 'User clicks chosen option. Then he clicks Save and Continue button.\
            And user will be transferred to the Payment step.' do
    sign_in(line_item.order.user)
    visit edit_order_path(line_item.order)
    expect(page).to have_current_path('/checkouts/delivery')

    within 'div.hidden-xs.mb-res-50' do
      choose("order_delivery_id_#{delivery.id}", allow_label_click: true)
      find('input[name="commit"]').click
    end
    expect(page).to have_current_path('/checkouts/payment')

    order_total = find('table.general-summary-table').all('td').last.text
    expect(order_total).to eq('€' + format('%.2f', (line_item.total_price + delivery.price).to_s))
  end

  scenario 'User does not choose any option. Then he clicks Save and Continue button.\
            And user won\'t be transferred to the Payment step.' do
    sign_in(line_item.order.user)
    visit edit_order_path(line_item.order)
    expect(page).to have_current_path('/checkouts/delivery')

    find('div.hidden-xs.mb-res-50').find('input[name="commit"]').click
    expect(page).to have_current_path('/checkouts/delivery')
  end

  scenario 'Guest try to visit Checkout page, the Delivery tab. He will be redirected to the Sign In page' do
    guest = create(:user, :guest)
    create(:line_item, order: create(:order, user: guest, step: 'delivery'))
    visit edit_order_path(line_item.order)
    expect(page).to have_content('You are not authorized to access this page.')
  end
end
