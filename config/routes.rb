Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    get 'sign_up', :to => 'users/registrations#new'
    get 'log_in', :to => 'users/sessions#new'
    get 'log_out', :to => 'users/sessions#destroy'
    get 'user/:id', :to => 'users/registrations#detail', as: 'detail'
  end

  get '/' => 'home#top'
  resources :aquariums
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
