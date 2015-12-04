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

#def home x
#  puts 'axlotl: ' + x
#  (x == '/movies') ? '/' : x
#end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  puts 'current_path = ' + current_path
  if current_path.respond_to? :should
    expect(current_path).to eq path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

=begin
Then /^(?:|I )should either be on (.+) or (.+)$/ do |page_a, page_b|
  current_path = home URI.parse(current_url).path
  path_a = path_to(page_a)
  path_b = path_to(page_b)
  if (path_a != current_path) && (path_b != current_path)
    fail "We are on the wrong page"
  end
end
=end
