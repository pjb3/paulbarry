module ApplicationHelper
  def flash_notification_class(flash_type)
    case flash_type.to_s
    when "alert", "error" then "danger"
    when "notice" then "success"
    else flash_type.to_s
    end
  end

  def formatted_timestamp(timestamp)
    if timestamp
      timestamp.in_time_zone("US/Pacific").strftime("%A, %B %e, %Y %l:%M%P %Z")
    end
  end
end
