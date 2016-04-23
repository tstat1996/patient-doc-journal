# Doctor model
require 'bcrypt'

class Doctor < ActiveRecord::Base
  include BCrypt
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :email, presence: true
  validates :password_hash, presence: true
  validate :name_capital
  validates :code, presence: true
  validates :code, uniqueness: true
  has_many :patients_doctors, dependent: :destroy
  has_many :patients, through: :patients_doctors
  accepts_nested_attributes_for :patients

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
end
