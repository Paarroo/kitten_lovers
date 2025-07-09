class UserMailer < Devise::Mailer
  helper MailerStylesHelper
  include Devise::Controllers::UrlHelpers
  default template_path: 'user_mailer'
  default from: ENV.fetch('DEVISE_MAILER_FROM', 'auth@kittenlovers.com')
  default reply_to: ENV.fetch('MAILER_REPLY_TO', 'support@kittenlovers.com')

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

  # Welcome email after signup (méthode personnalisée)
  def welcome_email(user)
    @user = user
    @login_url = new_user_session_url
    @app_name = 'KittenLovers'

    mail(
      to: @user.email,
      subject: "🐱 Bienvenue chez #{@app_name} !"
    )
  end

  # Order confirmation email (méthode personnalisée)
  def order_confirmation(order)
    @order = order
    @user = order.user
    @app_name = 'KittenLovers'
    @order_url = order_url(@order)
    @total_price = @order.total_price
    @order_items = @order.order_items.includes(:item)

    mail(
      to: @user.email,
      subject: "🛍️ Commande confirmée ##{@order.id}"
    )
  end
end
