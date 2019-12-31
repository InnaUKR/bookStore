# frozen_string_literal: true

require 'rails_helper'

feature 'Catalog', '
  In order to change the order of displayed books
  I as user or as guest
  I want to be able to change a filter(only one filter can be chosen from this list)
' do
  before do
    category = create(:category)
    @a_cheaper_book = create(:book, title: 'a', price: 1, category: category)
    @b_more_expensive_book = create(:book, title: 'b', price: 10, category: category)
    @other_category_book = create(:book)
  end

  scenario 'Guest change a filter' do
    visit root_path
    first(:xpath, "//a[@href='/categories?category=1']").click

    expect(page).to have_content(@a_cheaper_book.title)
    expect(page).to have_content(@b_more_expensive_book.title)
    expect(page).to_not have_content(@other_category_book.title)

    click_link('Price: Low to hight')
    expect(first('p.title').text).to eq(@a_cheaper_book.title)
    click_link('Price: Hight to low')
    expect(first('p.title').text).to eq(@b_more_expensive_book.title)
    click_link('Title: A - Z')
    expect(first('p.title').text).to eq(@a_cheaper_book.title)
    click_link('Title: Z - A')
    expect(first('p.title').text).to eq(@b_more_expensive_book.title)
  end

  scenario 'User change a filter' do
    sign_in(create(:user))
    visit root_path
    first(:xpath, "//a[@href='/categories?category=1']").click

    expect(page).to have_content(@a_cheaper_book.title)
    expect(page).to have_content(@b_more_expensive_book.title)
    expect(page).to_not have_content(@other_category_book.title)

    click_link('Price: Low to hight')
    expect(first('p.title').text).to eq(@a_cheaper_book.title)
    click_link('Price: Hight to low')
    expect(first('p.title').text).to eq(@b_more_expensive_book.title)
    click_link('Title: A - Z')
    expect(first('p.title').text).to eq(@a_cheaper_book.title)
    click_link('Title: Z - A')
    expect(first('p.title').text).to eq(@b_more_expensive_book.title)
  end
end
