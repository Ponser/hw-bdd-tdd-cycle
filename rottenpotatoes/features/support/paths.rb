# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the edit page for "(.+)"$/
      title = $1
      #puts "Searching for the edit page for #{title}"
      m = Movie.find_by title: title
      m ? '/movies/' + m.id.to_s + '/edit' : '/404'
    
    when /^the details page for "(.+)"$/
      m = Movie.find_by title: $1
      @prev_movie = m
      m ? '/movies/' + m.id.to_s : '/404'
      
    when /^Find Movies With Same Director$/
      '/movies/' + @prev_movie[:id].to_s + '/director'
      
    when /^the Similar Movies page for "(.+)"$/
      m = Movie.find_by title: $1
      '/movies/' + m[:id].to_s + '/similar'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

=begin
  def by_name(title)
    m = nil
    Movie.all.each do |movie|
      m = movie if movie.title == title
    end
    return m
  end  
=end
end


World(NavigationHelpers)
