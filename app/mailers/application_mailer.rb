class ApplicationMailer < ActionMailer::Base
  default from: 'KittenLovers <noreply@kitten-lovers.com>'
  layout 'mailer'

  private

  # Helper method to get the base URL for your application
  def app_url
    Rails.application.routes.url_helpers.root_url
  end

  # Helper method for consistent email styling
  def default_email_options
    {
      content_type: 'text/html',
      charset: 'UTF-8'
    }
  end
end
