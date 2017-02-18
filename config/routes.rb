Rails.application.routes.draw do
  root 'demo#index'

  # default route, may be obsolete in later versions of rails
  # get ':controller(/:action(/:id))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
