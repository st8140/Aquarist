Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get 'user/posts' => 'users/registrations#user_posts', as: 'user_posts'
    post 'users/guest_sign_in' => 'users/sessions#new_guest'
    get 'sign_up' => 'users/registrations#new'
    get 'log_in' => 'users/sessions#new'
    get 'log_out' => 'users/sessions#destroy'
    get 'user/:id' => 'users/registrations#detail', as: 'detail'
  end

  root 'home#top'
  get '/' => 'home#top'
  resources :aquaria
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
