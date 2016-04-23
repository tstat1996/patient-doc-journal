# Model that keeps relationship between patients and doctors
class PatientsDoctor < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor
end
