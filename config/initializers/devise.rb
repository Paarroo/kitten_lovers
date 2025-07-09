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

# Custom Devise Mailer pour override les méthodes par défaut
class UserMailer < Devise::Mailer
  # Override confirmation instructions
  def confirmation_instructions(record, token, opts = {})
    @user = record
    @token = token
    @confirmation_url = user_confirmation_url(confirmation_token: @token)
    @app_name = 'KittenLovers'

    mail(
      to: @user.email,
      subject: "📧 Confirmez votre compte #{@app_name}",
      template_name: 'confirmation_instructions'
    )
  end

  # Override reset password instructions
  def reset_password_instructions(record, token, opts = {})
    @user = record
    @token = token
    @reset_url = edit_user_password_url(reset_password_token: @token)
    @app_name = 'KittenLovers'

    mail(
      to: @user.email,
      subject: "🔐 Réinitialisation de votre mot de passe",
      template_name: 'reset_password_instructions'
    )
  end

  # Override password change notification
  def password_change(record, opts = {})
    @user = record
    @app_name = 'KittenLovers'
    @support_email = ENV.fetch('SUPPORT_EMAIL', 'support@kittenlovers.com')

    mail(
      to: @user.email,
      subject: "✅ Mot de passe modifié avec succès",
      template_name: 'password_changed_notification'
    )
  end

  # Override email change notification
  def email_changed(record, opts = {})
    @user = record
    @app_name = 'KittenLovers'

    mail(
      to: @user.email,
      subject: "📧 Adresse email modifiée",
      template_name: 'email_changed_notification'
    )
  end

  # Override unlock instructions
  def unlock_instructions(record, token, opts = {})
    @user = record
    @token = token
    @unlock_url = user_unlock_url(unlock_token: @token)
    @app_name = 'KittenLovers'

    mail(
      to: @user.email,
      subject: "🔒 Débloquez votre compte",
      template_name: 'unlock_instructions'
    )
  end
end
