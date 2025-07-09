class UserMailer < ApplicationMailer
  default from: 'noreply@kittenlovers.com'

  def welcome_email(user)
    @user = user
    @login_url = new_user_session_url
    @app_name = 'KittenLovers'

    mail(
      to: @user.email,
      subject: "🐱 Bienvenue chez #{@app_name} !"
    )
  end

  def reset_password_instructions(user, token)
    @user = user
    @token = token
    @reset_url = edit_user_password_url(reset_password_token: @token)
    @app_name = 'KittenLovers'

    mail(
      to: @user.email,
      subject: "🔐 Réinitialisation de votre mot de passe"
    )
  end

  def password_changed_notification(user)
    @user = user
    @app_name = 'KittenLovers'
    @support_email = 'support@kittenlovers.com'

    mail(
      to: @user.email,
      subject: "✅ Mot de passe modifié avec succès"
    )
  end

  def confirmation_instructions(user, token)
    @user = user
    @token = token
    @confirmation_url = user_confirmation_url(confirmation_token: @token)
    @app_name = 'KittenLovers'

    mail(
      to: @user.email,
      subject: "📧 Confirmez votre compte #{@app_name}"
    )
  end

  def email_changed_notification(user, old_email)
    @user = user
    @old_email = old_email
    @new_email = user.email
    @app_name = 'KittenLovers'

    mail(
      to: [ @old_email, @new_email ],
      subject: "📧 Adresse email modifiée"
    )
  end

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

  # Account locked notification
  def unlock_instructions(user, token)
    @user = user
    @token = token
    @unlock_url = user_unlock_url(unlock_token: @token)
    @app_name = 'KittenLovers'

    mail(
      to: @user.email,
      subject: "🔒 Débloquez votre compte"
    )
  end

  private

  # Helper method for common email data
  def set_common_data
    @app_name = 'KittenLovers'
    @website_url = root_url
    @support_email = 'support@kittenlovers.com'
    @unsubscribe_url = '#' # À implémenter si nécessaire
  end
end
