module ApplicationHelper
  def flash_category(level)
    case level
    when :notice
      "info"
    when :success
      "success"
    when :error
      "error"
    when :alert
      "error"
    end
  end
end
