module ApplicationHelper

 # Return true if current_user is owner, false if not or if object has no user_id
  def is_owner?(object)
    return nil if(current_user.nil? || !object.respond_to?(:user_id))
    current_user.try(:id) == object.try(:user_id)
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_sym
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in hello") do 
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message 
        end)
    end
    nil
  end

end
