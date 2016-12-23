Rails.application.routes.draw do
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
#get 'welcome/index'
resources :articles do
  resources :comments
end
#root 'welcome#index'
#resources :articlesaa
root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
