class Comment < ActiveRecord::Base
  belongs_to :journal
  belongs_to :patient
  accepts_nested_attributes_for :patient
  accepts_nested_attributes_for :journal
end
