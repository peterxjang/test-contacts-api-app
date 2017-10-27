class Contact < ApplicationRecord
  def friendly_time
    created_at.strftime("%B %e, %Y")
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
