Rails.application.routes.draw do
  resources :trees
  resources :lands
  resources :certificates
  resources :officers
  resources :vehicles
  resources :users do
    collection do
      post :sign_up
      post :sign_in
      get :gen_keys
    end
  end
end
