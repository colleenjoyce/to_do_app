TodoApp::Application.routes.draw do
  root :to => 'items#index'
  resources :items
end