module ApplicationHelper
  
  def avatar_for(user, options = { size: "150x150"})
    size = options[:size] || "150x150"
    if user.avatar.url
      image_tag user.avatar.url, size: size, class: "img-circle"
    else
      image_tag 'http://www.femto.it/wp-content/uploads/2014/04/default-user-avatar.png', size: size, class: "img-circle"
    end
  end
  
  ALERT_TYPES = [:success, :info, :warning, :danger] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash(options = {})
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless ALERT_TYPES.include?(type)

      tag_class = options.extract!(:class)[:class]
      tag_options = {
        class: "alert fade in alert-#{type} #{tag_class}"
      }.merge(options)

      close_button = content_tag(:button, raw("&times;"), type: "button", class: "close", "data-dismiss" => "alert")

      Array(message).each do |msg|
        text = content_tag(:div, close_button + msg, tag_options)
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
  def is_admin?
    current_user && current_user.is_admin?
  end
  
  def set_title(title)
    return if title.empty?
    content_for :title do 
      "#{title} - Code I Learn"
    end
  end
  
  def set_description(description)
    return if description.empty?
    content_for :description do
      description
    end
  end
end
