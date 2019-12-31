# frozen_string_literal: true

desc 'Counter cache for category has many books'

task book_counter: :environment do
  Category.all.each do |c|
    Category.reset_counters(c.id, :books)
  end
end
