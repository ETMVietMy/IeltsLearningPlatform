module ApplicationHelper

  def bootstrap_class_for flash_type
    # byebug
    { success: 'alert-success', alert: 'alert-danger', error: 'alert-danger', notice: 'alert-warning'}[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    flash.map do |msg_type, message|
      content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade show") do
        content_tag(:button, '&times;'.html_safe, class: 'close', data: {dismiss: 'alert'}) +
        message
      end
    end.join.html_safe
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def is_active_class(name)
    case name
      when 'dashboard'
        return true if current_page?(controller: 'dashboard')
      when 'profile'
        return true if current_page?(controller: '')
      when 'inbox'
        return true if controller.controller_name == 'messages' && ['index', 'new', 'show'].include?(controller.action_name)
      when 'sent'
        return true if controller.controller_name == 'messages' && ['sent'].include?(controller.action_name)
      when 'writings'
        return true if current_page?(controller: 'writings') || current_page?(controller: 'tasks', action: 'suggest')
      when 'teachers'
        return true if current_page?(controller: 'teachers')
      when 'follows'
        return true if current_page?(controller: 'follows')
    end
  end

  def avatar_or_default(user)
    user.has_avatar? ? user.avatar_url : asset_path('avatar.png')
  end
end
