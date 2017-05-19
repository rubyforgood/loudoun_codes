module ApplicationHelper
  def flash_class(level)
    case level
    when :notice
      "alert alert-info"
    when :success
      "alert alert-success"
    when :error
      "alert alert-error"
    when :alert
      "alert alert-error"
    end
  end
end
