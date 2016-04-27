require 'bcrypt'

class Patient < ActiveRecord::Base
  include BCrypt
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password_hash, presence: true
  validate :name_capital
  validate :proper_email
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

  def proper_email
    at_sign = email.scan(/[\@]/)
    index_at_sign = email =~ /[\@]/
    text_at_end = email.scan(/\@\w+\.\w+/)
    errors.add(:email, 'Missing @ sign') if at_sign.empty?
    errors.add(:email, 'Email needs text before @') if index_at_sign == 0
    errors.add(:email, 'Email needs text after @') if index_at_sign == email.length - 1
    errors.add(:email, 'Email needs text surrounding the . after @') if text_at_end.eql?([])
  end

  def number_comments
    counter = 0
    journals.each do |journal|
      counter += journal.comments.size
    end
    counter
  end
end
