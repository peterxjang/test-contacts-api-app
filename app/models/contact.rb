class Contact < ApplicationRecord
  belongs_to :user

  def friendly_time
    created_at.strftime("%B %e, %Y")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def as_json(options={})
    options[:methods] = [:full_name, :friendly_time]
    options[:include] = [{:user => {:except => :password_digest}}]
    super
  end
end
