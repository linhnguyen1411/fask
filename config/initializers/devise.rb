Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.scoped_views = true

  config.sign_out_via = Rails.env.test? ? :get : :delete

  config.omniauth :framgia, ENV["APP_ID"], ENV["APP_SECRET"],
    client_options: {
      site: "http://10.0.1.14/",
      authorize_url: "https://wsm.framgia.vn/authorize",
      token_url: "http://10.0.1.14/auth/access_token"
    }

end
