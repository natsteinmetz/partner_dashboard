PartnerDashboard::Application.routes.draw do

  get "professionals/index"

  devise_for :users

  root :to => "students#index"

  resources :relationships


  resources :mentorships


  resources :employments


  resources :students


  resources :professionals


  resources :partners

  namespace :admin do
    root :to => "base#index"
    resources :partners
    resources :professionals
  end
end
