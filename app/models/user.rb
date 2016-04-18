# require 'bcrypt'

class User < ActiveRecord::Base
  # include BCrypt
  has_many :statuses, dependent: :destroy
  has_many :groups_users, dependent: :destroy
  has_many :groups, through: :groups_users
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
  validates :email, presence: true
  validates :password_hash, presence: true
  validate :name_capital

  def name_capital
    capital = name =~ /[A-Z]/
    errors.add(:name, 'name is not capitalized') if capital != 0
  end

  def password
    @password ||= Password.new(password_hash) unless password_hash.nil?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def is_this_doctor
  	is_doctor = "true" if "0"
  	is_doctor = "false" if "1"
  end
end
