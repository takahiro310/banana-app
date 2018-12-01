Rails.application.routes.draw do
  root 'top#index'
  get 'q/:url_key' => 'top#show'

  root  to: 'create_image#index'
  post 'create_image/exec', to: 'create_image#exec',  as: 'create_image'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
