class User < ApplicationRecord
  enum role: { basic: 0, manager: 1, admin: 2 }, _suffix: :role

  has_secure_password

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :registrations, dependent: :destroy
  has_many :events, through: :registrations

  def registered_for?(event)
    events.include?(event)
  end

  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validates :username, presence: true
  validates :usersurname, presence: true

  validate :password_complexity

  def author?(obj)
    obj.user == self
  end

  def guest?
    false
  end

  private

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])/
    errors.add :password, 'complexity requirement not met. Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit'
  end
end
