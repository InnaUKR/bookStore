# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for admin' do
    let(:user) { create :admin }
    it { is_expected.to be_able_to :manage, :all }
  end

  describe 'for guest' do
    let(:user) { create :user, guest: true }
    let(:other_user) { create(:user) }
    let(:order) { create(:order, user: user) }
    let(:other_user_order) { create(:order, user: other_user) }
    let(:book) { create(:book) }

    it { is_expected.not_to be_able_to :manege, :all }
    it { is_expected.not_to be_able_to :create, Review }
    it { is_expected.to be_able_to :read, Book }
    it { is_expected.to be_able_to :show, book }
    it { is_expected.to be_able_to :read, Category }
    it { is_expected.to be_able_to :read, order, user: user }
    it { is_expected.not_to be_able_to :read, other_user_order, user: user }
    it { is_expected.not_to be_able_to :edit, Order }
  end

  describe 'for user' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:book) { create(:book) }
    let(:order) { create(:order, user: user) }
    let(:other_user_order) { create(:order, user: other_user) }

    it { is_expected.not_to be_able_to :manege, :all }
    it { is_expected.to be_able_to :read, Book }
    it { is_expected.to be_able_to :show, book }
    it { is_expected.to be_able_to :read, Category }
    it { is_expected.to be_able_to :update, order, user: user }
    it { is_expected.not_to be_able_to :update, other_user_order, user: other_user }
    it { is_expected.to be_able_to :create, Review }
    it { is_expected.to be_able_to :edit, Order }
  end
end
