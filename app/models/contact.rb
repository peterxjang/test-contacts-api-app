class Contact < ApplicationRecord
  def friendly_time
    created_at.strftime("%B %e, %Y")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def as_json(options={})
    options[:methods] = [:full_name, :friendly_time]
    super
  end
end
