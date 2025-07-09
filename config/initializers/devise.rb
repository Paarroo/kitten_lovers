Devise.setup do |config|
  # Configuration des emails avec vos variables d'environnement
  config.mailer_sender = ENV.fetch('DEVISE_MAILER_FROM', 'auth@kittenlovers.com')

  # Utilisation de notre UserMailer personnalisé
  config.mailer = 'UserMailer'

  # Configuration des notifications par email
  config.send_email_changed_notification = true
  config.send_password_change_notification = true

  # Autres configurations Devise existantes...
  config.authentication_keys = [ :email ]
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [ :http_auth ]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 2.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
