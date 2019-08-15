module ApplicationHelper
  def flash_notices
    if flash.keys.present?
      if flash.keys.count == 1
       content_tag(:div, flash[:"#{flash.keys.first}"], class: ["alert", "alert-primary"]) 

      else
        flash.keys.each do |key|
          content_tag(:div, flash[:"#{key}"], class: ["alert", "alert-primary"])
        end
      end
    end
  end

  def money(number)
    "$#{sprintf "%.2f", number}"
  end

  def time_month_date_year(timestamp)
    timestamp.strftime("%B %-d, %Y")
  end
end
