class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method def doctor_logged_in?
    session[:doctor_id]
  end

  helper_method def current_doctor
    @current_user ||= Doctor.find(session[:doctor_id]) if doctor_logged_in?
  end

  helper_method def patient_logged_in?
    session[:patient_id]
  end

  helper_method def current_patient
    @current_patient ||= Patient.find(session[:patient_id]) if patient_logged_in?
  end
end
