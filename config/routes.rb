Rails.application.routes.draw do
  resources :trees do
    post :cut_request, on: :collection
    get :requests, on: :collection
    get :ledger, on: :collection
    post :approve, on: :collection
  end
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
