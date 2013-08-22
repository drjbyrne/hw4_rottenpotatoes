# spec/factories/movies.rb
require 'faker'

FactoryGirl.define do
  factory :movie do |m|
    m.title { Faker::Movie.words }
    m.release_date "14 June 2001"
  end
end
