class Contact < ApplicationRecord
  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true

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
