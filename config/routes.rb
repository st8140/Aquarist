Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :mailer => 'users/mailer'
  } 

  devise_scope :user do
    get 'users/:id/liked_aquaria' => 'users/registrations#liked_aquaria', as: 'users_liked_aquaria'
    get 'users/:id/posts' => 'users/registrations#user_posts', as: 'users_posts'
    post 'users/guest_sign_in' => 'users/sessions#new_guest'
    get 'sign_up' => 'users/registrations#new'
    get 'log_in' => 'users/sessions#new'
    get 'log_out' => 'users/sessions#destroy'
    get 'users/:id/detail' => 'users/registrations#detail', as: 'detail'
  end

  root 'home#top'
  get '/' => 'home#top'
  resources :aquaria do
    collection do
      get 'search'
    end
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :maps, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
