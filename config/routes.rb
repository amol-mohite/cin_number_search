Rails.application.routes.draw do
  get 'search/search_cin_number'
  post 'search/search_cin_number'
  post 'history/clear_history'
  devise_for :users
  root 'search#search_cin_number'
  resources :history
end
