unless Rails.env.production?
  ActionMailer::Base.default_url_options = { host: 'localhost:3000' }
  ActionMailer::Base.delivery_method = :file
end
