class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'], password: ENV['BASIC_AUTH_PASSWORD']
end
