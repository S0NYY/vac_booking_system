module StyledDateHelper
  
  def styled_date(current_date)
    current_date&.strftime("%Y-%m-%d %H:%M")
  end

end
