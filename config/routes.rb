Rails.application.routes.draw do
  resource :deploys, only: :create
end
