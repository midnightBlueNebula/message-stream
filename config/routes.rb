Rails.application.routes.draw do
  
  root   'static_pages#welcome'

  post   '/stream'                    , to: 'posts#create'

  post   '/like/message'              , to: 'likes#like'
  post   '/dislike/message'           , to: 'likes#dislike'

  post   '/confirmation'              , to: 'confirmations#confirm'

  get    '/stream'                    , to: 'streams#show'

  get    '/users'                     , to: 'static_pages#users'
  get    '/confirmation_queue'        , to: 'static_pages#confirmation_queue'
  get    '/best_of'                   , to: 'static_pages#best_posts'
  get    '/prime_league'              , to: 'static_pages#top_users'
  get    '/exiles'                    , to: 'static_pages#banned_users'

  get    '/profile/:id'               , to: 'profiles#show'

  get    '/login'                     , to: 'sessions#new'
  post   '/login'                     , to: 'sessions#create'
  delete '/logout'                    , to: 'sessions#destroy'

  get    '/register'                  , to: 'registrations#new'
  post   '/register'                  , to: 'registrations#create'

end
