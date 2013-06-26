PartnerDashboard::Application.routes.draw do

  root :to => "home#index"


  match "/invite_requests/new", to: "invite_requests#new", via: :get, as: :new_invite_request
  #TODO: I don't want this send invite path to be public
  match "/invite_requests", to: "invite_requests#create", via: :post, as: :invite_requests

  resources :relationships, only: :create
  resources :students, only: [:index, :show]
  resources :courses, only: :index

  namespace :admin do
    root :to => "base#index"
    resources :partners, only: :index
    resources :professionals, only: :index
    resources :students, only: :index
    resources :relationships, except: [:show, :edit]
   end

  devise_for :users, :skip => :invitations

  #TODO, maybe you can yank some of the admin specific routes in here and put them above in the admin namespace block?
  devise_scope :user do
    get "/users/invitation/accept(.:format)" => "devise/invitations#edit", :as => "accept_user_invitation"
    put "admin/users/invitation(.:format)" => "admin/invitations#update"
    get "/users/invitation/remove(.:format)" => "admin/invitations#destroy", :as => "remove_user_invitation"
    post "admin/users/invitation(.:format)" => "admin/invitations#create", :as => "user_invitation"
    get "admin/users/invitation/new(.:format)" => "admin/invitations#new", :as => "new_user_invitation"
    get "admin/users/invitation/new_partner" => "admin/invitations#new_partner"
    post "admin/users/invitation/create_partner" => "admin/invitations#create_partner"
    get "admin/users/invitation/new_professional" => "admin/invitations#new_professional"
    post "admin/users/invitation/create_professional" => "admin/invitations#create_professional"
  end
end
