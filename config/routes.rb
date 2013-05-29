PartnerDashboard::Application.routes.draw do

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
    resources :students
  end
end
