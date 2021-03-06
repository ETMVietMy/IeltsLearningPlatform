Rails.application.routes.draw do

  authenticate :user do
    get 'dashboard', to: 'dashboard#index'

    scope '/dashboard' do
      # teacher
      resources :teachers, only: [:new, :create, :edit, :update, :index, :show]
      post 'teacher/search', to: 'teachers#search'

      # follows
      resources :follows, only: [:new, :index]
      delete 'follow', to: 'follows#destroy'
      post 'follows_add', to: 'follows#create'

      # account
      get 'account', to: 'account#index'
      get 'account/edit', to: 'account#edit'
      patch 'account', to: 'account#update'
      get 'account/change-password', to: 'account#change_password'
      get 'account/edit-teacher-info', to: 'account#edit_teacher'
      patch 'account/edit-teacher-info', to: 'account#update_teacher'

      # task
      get 'tasks/suggest', to: 'tasks#suggest'
      get 'tasks/:task_id/writings/new', to: 'writings#new', as: 'new_writing'
      post 'tasks/:task_id/writings', to: 'writings#create', as: 'create_writing'

      # writing
      resources :writings, only: [:index, :show, :create]
      get 'writing/:writing_id/request', to: 'writings#new_request', as: 'new_request'
      post 'writing/:writing_id/request/:teacher_id', to: 'writings#create_request', as: 'create_request'
      # resources :tasks, only: [:show] do
      #   resources :writings, only: [:new, :create]
      # end

      # message
      resources :messages
      get 'messages_sent', to: 'messages#sent'
      delete 'messages_sent', to: 'messages#delete_sent'
      get 'accept_request/:message_id', to: 'messages#accept_request', as: 'accept_request'
      get 'deny_request/:message_id', to: 'messages#deny_request', as: 'deny_request'
      get 'accept_correction/:message_id', to: 'messages#accept_correction', as: 'accept_correction'
      get 'deny_correction/:message_id', to: 'messages#deny_correction', as: 'deny_correction'

      # correction
      resources :corrections, only: [:index, :edit, :update, :show]
      get 'accept_deny_correction/:id', to: 'corrections#accept_deny_correction', as: 'accept_deny_correction'
      get 'refuse_deny_correction/:id', to: 'corrections#refuse_deny_correction', as: 'refuse_deny_correction'

      # transactions
      resources :transactions, only: [:index, :create]
    end

    resources :teachers do
      resources :comments, only: :create
    end

    

  	resources :tasks
    resources :ratings, only: :update

  end



  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
