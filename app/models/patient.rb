# Patient model
require 'bcrypt'

class Patient < ActiveRecord::Base
  include BCrypt
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
  validates :email, presence: true
  validates :password_hash, presence: true
  validate :name_capital
  has_many :patients_doctors, dependent: :destroy
  has_many :doctors, through: :patients_doctors
  has_many :journals
  accepts_nested_attributes_for :doctors
  accepts_nested_attributes_for :journals
  has_many :comments, through: :journals
  accepts_nested_attributes_for :comments

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

  def add_doctor(doc_code)
    doc = Doctor.find_by(code: doc_code)
    return false if doc.nil?
    return false if doctors.include?(doc)
    doc.patients << self
    true
  end

  def add_entry(entry)
    journals << entry
  end
end
