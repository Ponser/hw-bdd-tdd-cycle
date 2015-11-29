Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

#When /^(?:|I )go to the edit page for "(.+)"$/ do |page_name|
#  puts 'The page name is ' + page_name
#  visit path_to('/edit')
#end

Then /^the director of "(.+)" should be "(.+)"$/ do |mtitle,mdir|
  #puts "#{mtitle} was directed by #{mdir}"
  movie = Movie.find_by title: mtitle
  #puts 'The director on file is ' + movie.director
  fail "The 'director' field is incorrect" if !(movie.director) || movie.director != mdir
end
