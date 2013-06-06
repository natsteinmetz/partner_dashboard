PartnerDashboard::Application.routes.draw do

  root :to => "home#index"

  match "/request_invite", to: "home#request_invite", via: :get, as: :request_invite

  resources :relationships
  resources :students

  namespace :admin do
    root :to => "base#index"
    resources :partners
    resources :professionals
    resources :students
  end

  devise_for :users, :skip => :invitations

  #TODO, maybe you can yank some of the admin specific routes in here and put them above in the admin namespace block?
  devise_scope :user do
    get "/users/invitation/accept(.:format)" => "devise/invitations#edit", :as => "accept_user_invitation"
    put "admin/users/invitation(.:format)" => "admin/invitations#update"
    get "/users/invitation/remove(.:format)" => "admin/invitations#destroy", :as => "remove_user_invitation"
    post "admin/users/invitation(.:format)" => "admin/invitations#create", :as => "user_invitation"
    get "admin/users/invitation/new(.:format)" => "admin/invitations#new", :as => "new_user_invitation"
  end
end
