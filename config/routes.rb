Rails.application.routes.draw do

  get 'dashboard', to: 'dashboard#index'

  scope '/dashboard' do
    resources :teachers, only: [:new, :create, :edit, :update, :index, :show]
    post 'teacher/search', to: 'teachers#search'

    resources :follows, only: [:new, :index]
    delete 'follows', to: 'follows#destroy'
    post 'follows_add', to: 'follows#create'
  end

	resources :students
	resources :tasks

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
