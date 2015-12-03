Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get '/movies/:id/similar'  => 'movies#similar', :as => :movies_similar
  get '/movies/:id/destroy'  => 'movies#destroy', :as => :movies_destroy
#  resources :movies do
#    get 'director'
#  end
end
