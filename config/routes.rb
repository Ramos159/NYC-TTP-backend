Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post'/login',to:"auth#login"
  post'/auto_login',to:"auth#autologin"
  post'/transaction/create',to:"transaction#create"
  post'/register', to:"user#create"
  get'/get_stock/:ticker',to:"stock#get_stock"
  delete'/sell',to:"transaction#sell"
end
