module MailerStylesHelper
  def email_container_style
    "width: 100%; max-width: 600px; margin: 0 auto; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background-color: #ffffff;"
  end

  def email_wrapper_style
    "background-color: #f8f9fa; padding: 30px 20px; min-height: 100vh;"
  end

  def email_header_style(color_theme = 'primary')
    case color_theme
    when 'danger', 'reset'
      "background: linear-gradient(135deg, #dc3545 0%, #c82333 100%); padding: 40px 30px; text-align: center; border-radius: 12px 12px 0 0;"
    when 'success', 'welcome'
      "background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%); padding: 40px 30px; text-align: center; border-radius: 12px 12px 0 0;"
    when 'warning'
      "background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%); padding: 40px 30px; text-align: center; border-radius: 12px 12px 0 0;"
    else # primary/default
      "background: linear-gradient(135deg, #f4a261 0%, #e76f51 100%); padding: 40px 30px; text-align: center; border-radius: 12px 12px 0 0;"
    end
  end

  def email_logo_style
    "font-size: 3rem; margin-bottom: 15px; display: block;"
  end

  def email_header_title_style
    "color: #ffffff; font-size: 28px; font-weight: 700; margin: 0 0 10px 0; line-height: 1.2;"
  end

  def email_header_subtitle_style
    "color: rgba(255, 255, 255, 0.9); font-size: 16px; margin: 0; font-weight: 400;"
  end

  def email_content_style
    "background-color: #ffffff; padding: 40px 30px; border-left: 1px solid #e9ecef; border-right: 1px solid #e9ecef;"
  end

  def email_content_title_style
    "color: #2d3748; font-size: 24px; font-weight: 600; margin: 0 0 20px 0; line-height: 1.3;"
  end

  def email_content_text_style
    "color: #4a5568; font-size: 16px; line-height: 1.6; margin: 0 0 20px 0;"
  end

  def email_button_style(variant = 'primary')
    base_style = "display: inline-block; color: #ffffff !important; text-decoration: none !important; padding: 16px 32px; border-radius: 8px; font-weight: 600; font-size: 16px; text-align: center; margin: 20px 0;"

    case variant
    when 'danger'
      "#{base_style} background: linear-gradient(135deg, #dc3545 0%, #c82333 100%); box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);"
    when 'success'
      "#{base_style} background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%); box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);"
    when 'warning'
      "#{base_style} background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%); box-shadow: 0 4px 12px rgba(255, 193, 7, 0.3); color: #212529 !important;"
    else # primary
      "#{base_style} background: linear-gradient(135deg, #f4a261 0%, #e76f51 100%); box-shadow: 0 4px 12px rgba(244, 162, 97, 0.3);"
    end
  end

  def email_info_box_style(variant = 'info')
    base_style = "border-radius: 8px; padding: 20px; margin: 25px 0;"

    case variant
    when 'success'
      "#{base_style} background-color: #d4edda; border: 1px solid #c3e6cb; color: #155724;"
    when 'danger'
      "#{base_style} background-color: #f8d7da; border: 1px solid #f5c6cb; color: #721c24;"
    when 'warning'
      "#{base_style} background-color: #fff3cd; border: 1px solid #ffeaa7; color: #856404;"
    else # info
      "#{base_style} background-color: #d1ecf1; border: 1px solid #bee5eb; color: #0c5460;"
    end
  end

  def email_security_notice_style
    "background-color: #e3f2fd; border-left: 4px solid #2196f3; padding: 15px 20px; margin: 25px 0; border-radius: 0 6px 6px 0;"
  end

  def email_security_title_style
    "color: #1565c0; font-size: 16px; font-weight: 600; margin: 0 0 8px 0;"
  end

  def email_security_text_style
    "color: #1976d2; font-size: 14px; margin: 0;"
  end

  def email_footer_style
    "background-color: #2d3748; color: #ffffff; padding: 30px; text-align: center; border-radius: 0 0 12px 12px;"
  end

  def email_footer_text_style
    "color: rgba(255, 255, 255, 0.8); font-size: 14px; margin: 0 0 10px 0;"
  end

  def email_footer_link_style
    "color: rgba(255, 255, 255, 0.8); text-decoration: none; margin: 0 15px; font-size: 14px;"
  end

  def email_link_style
    "color: #f4a261; text-decoration: none; font-weight: 500;"
  end

  def email_list_style
    "color: #4a5568; font-size: 16px; line-height: 1.6; margin: 20px 0; padding-left: 20px;"
  end

  def responsive_container_style
    "width: 100% !important; max-width: 100% !important;"
  end

  def responsive_header_style
    "padding: 30px 20px !important;"
  end

  def responsive_title_style
    "font-size: 24px !important;"
  end

  def responsive_content_style
    "padding: 30px 20px !important;"
  end

  def responsive_button_style
    "display: block !important; width: 100% !important; box-sizing: border-box !important;"
  end
end
