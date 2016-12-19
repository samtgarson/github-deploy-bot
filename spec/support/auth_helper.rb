module AuthHelper
  def http_login
    user = ENV['BASIC_AUTH_USER']
    pw = ENV['BASIC_AUTH_PASSWORD']
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
  end
end
