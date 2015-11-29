Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get '/movies/:id/director'  => 'movies#director', :as => :movies_director
  get '/movies/:id/similar'  => 'movies#similar', :as => :movies_similar
#  resources :movies do
#    get 'director'
#  end
end
