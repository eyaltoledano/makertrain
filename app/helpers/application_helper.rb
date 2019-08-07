module ApplicationHelper
  def flash_notices
    if flash[:notice].present?
      if flash[:notice].is_a? String
        flash[:notice]
      else
        flash[:notice].errors.each do |error|
          error.full_message
        end
      end
    end
  end

end
