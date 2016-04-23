# Journal model
class Journal < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :body, presence: true
  validates :body, uniqueness: true
  belongs_to :patient
  accepts_nested_attributes_for :patient
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments

  def add_comment(comment_params)
    comments << comment_params
  end
end
