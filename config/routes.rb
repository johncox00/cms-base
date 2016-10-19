Rails.application.routes.draw do
  resources :offers
  resources :content_items do
    resources :content_item_revisions
  end
  resources :cms_pages

  resources :change_sets
  root to: 'visitors#index'
  devise_for :users
  resources :users

  put 'change_sets/:id/accept' => 'change_sets#accept', as: 'accept_change_set'
  put 'change_sets/:id/reject' => 'change_sets#accept', as: 'reject_change_set'
  put 'cms_pages/:id/content_items' => 'cms_pages#update_content_items'
  put 'users/:id/update_roles' => 'users#update_roles', as: 'user_update_roles'
end
