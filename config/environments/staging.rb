require_relative 'production'

Rails.application.configure do
  if ENV['HTTP_USER'].present?
    # enable basic authentication
    config.middleware.use '::Rack::Auth::Basic' do |user, password|
      [user, password] == [ENV['HTTP_USER'], ENV['HTTP_PASSWORD']]
    end
  end
end
