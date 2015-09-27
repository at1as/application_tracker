module ApplicationHelper

 # Return true if current_user is owner, false if not or if object has no user_id
  def is_owner?(object)
    return nil if(current_user.nil? || !object.respond_to?(:user_id))
    current_user.try(:id) == object.try(:user_id)
  end

  def days_ago(date)
    diff = Time.now - date.to_time
    puts "DA", date
    puts "DIF", diff
    return date if diff < 86400
    "#{"day".pluralize(diff.to_i / 86400)} ago"
  end
end
