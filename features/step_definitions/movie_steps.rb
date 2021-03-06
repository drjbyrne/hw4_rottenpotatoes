Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
  if Movie.where(["title = ?", movie[:title]]).length == 0
          Movie.create!(movie)
        end
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  Movie.where("title = ? AND director = ?", title, director).length > 0
end


Then /^I should see "(.*)" before "(.*)"$/ do |e1, e2|
  assert page.body.index(e1) < page.body.index(e2)
end

When /^I (un)?check the following ratings: (.*)$/ do |uncheck, rating_list|
    ratings = rating_list.split(', ').map {|rat| "ratings_#{rat}"}
    ratings.each do |rating|
        if uncheck
             uncheck(rating)
           else
             check(rating)
           end
    end
end
