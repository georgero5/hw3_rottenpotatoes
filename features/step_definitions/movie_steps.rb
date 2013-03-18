# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie);
  end
  #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  # ensure that that e1 occurs before e2.
  # page.content is the entire content of the page as a string.
  cont = page.body
  ind1 = cont.index(e1)
  ind2 = cont.index(e2)
  assert ind1, "#{e1}, #{e2}"
  assert ind2, "#{e1}, #{e2}"
  assert ind1 < ind2, "#{ind1}, #{ind2}"
end

Then /^results should be sorted:$/ do |table|
  table.hashes.each do |movie_pair|
    step %Q{I should see "#{movie_pair[:before]}" before "#{movie_pair[:after]}"}
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |field|
    step %Q{I #{uncheck}check "ratings_#{field}"}
  end
end

Then /^I should (not )?see all of the movies:$/ do |nt, movies_table|
  movies_table.hashes.each do |movie|
    step %Q{I should #{nt}see "#{movie[:title]}"}
  end
  rows = movies_table.hashes.count
end