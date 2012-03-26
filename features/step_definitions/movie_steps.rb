Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie_title, director|
  step "I should be on the details page for \"#{movie_title}\""
  step "I should see \"Director: #{director}\""
end


