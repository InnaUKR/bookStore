require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  let(:order) { create(:order) }
  steps = ['address', 'delivery', 'payment', 'confirm', 'complete']

  describe 'GET #show' do
    steps.each do |step|
      context step do
        before { get :show, params: { id: step }, session: { order_id: order.id } }

        it '@form is instance of "#{step.capitalize}Form".constantize' do
          expect(assigns[:form]).to be_instance_of "#{step.capitalize}Form".constantize
        end

        it 'render step view' do
          expect(response).to render_template step
        end
      end
    end
  end

  describe 'GET #index' do
    steps.each do |step|
      context step do
        before do
          order.update(step: step)
          get :index, session: { order_id: order.id }
        end

        it 'render step view' do
          expect(response).to redirect_to :action => :show, :id => step
        end
      end
    end

    it 'when  @order.step is nil' do
      get :index, session: { order_id: order.id }
      expect(response).to redirect_to :action => :show, :id => :address
    end
  end

  describe 'POST #update' do
    steps[0...steps.length - 1].each_with_index do |step, index|
      context 'with valid attributes' do
        before do
          order.update(step: step)
          step_class = "#{step.capitalize}Form".constantize
          allow(step_class).to receive(:from_params).and_return(step_class.new)
          allow_any_instance_of(step_class).to receive(:update!)
          allow_any_instance_of(step_class).to receive(:valid?).and_return(true)
          put :update, params: { id: step }, session: { order_id: order.id }
        end

        it "redirects from #{step} to #{steps[index + 1]}" do
          expect(response).to redirect_to("/checkouts/#{steps[index + 1]}")
        end
      end

      context 'with invalid attributes' do
        before do
          order.update(step: step)
          step_class = "#{step.capitalize}Form".constantize
          allow(step_class).to receive(:from_params).and_return(step_class.new)
          allow_any_instance_of(step_class).to receive(:update!)
          allow_any_instance_of(step_class).to receive(:valid?).and_return(false)
          put :update, params: { id: step }, session: { order_id: order.id }
        end

        it "renders #{step} step" do
          expect(response).to render_template("checkouts/#{step}")
        end
      end
    end

    steps[0..2].each do |step|
      context 'goes from confirm form to' do
        before do
          order.update(step: 'confirm')
          step_class = "#{step.capitalize}Form".constantize
          allow_any_instance_of(step_class).to receive(:valid?).and_return(true)
          allow_any_instance_of(step_class).to receive(:update!)
          allow(step_class).to receive(:from_params).and_return(step_class.new)

          put :update, params: { id: step }, session: { order_id: order.id }
        end

        it "#{step} and after successful update redirect back to confirm" do
          expect(response).to redirect_to("/checkouts/confirm")
        end
      end
    end
  end
end