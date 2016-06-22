module ApplicationHelper
  def phone_to(number)
    link_to number, "tel:#{number}"
  end
end
