Rails.application.routes.draw do

  get 'dashboard', to: 'dashboard#index'

  scope '/dashboard' do
    resources :teachers, only: [:new, :create, :edit, :update, :index, :show]
    post 'teacher/search', to: 'teachers#search'

    resources :follows, only: [:new, :index]
    delete 'follows', to: 'follows#destroy'
    post 'follows_add', to: 'follows#create'

    get 'account', to: 'account#index'
    get 'account/edit', to: 'account#edit'
    patch 'account', to: 'account#update'
    get 'account/change-password', to: 'account#change_password' 
    get 'account/edit-teacher-info', to: 'account#edit_teacher'
    patch 'account/edit-teacher-info', to: 'account#update_teacher'
  end

	resources :teachers do
    resources :comments, only: :create
  end

	resources :tasks
  

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
