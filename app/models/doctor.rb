# Doctor model
require 'bcrypt'

class Doctor < ActiveRecord::Base
  include BCrypt
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password_hash, presence: true
  validate :name_capital
  validate :proper_email
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

  def proper_email
    at_sign = email.scan(/[\@]/)
    index_at_sign = email =~ /[\@]/
    text_at_end = email.scan(/\@\w+\.\w+/)
    errors.add(:email, 'Missing @ sign') if at_sign.empty?
    errors.add(:email, 'Email needs text before @') if index_at_sign == 0
    errors.add(:email, 'Email needs text after @') if index_at_sign == email.length - 1
    errors.add(:email, 'Email needs text surrounding the . after @') if text_at_end.eql?([])
  end
end
