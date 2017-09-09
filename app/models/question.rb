class Question < ApplicationRecord
  validates :title, :body, presence: true
  has_many :answers
  belongs_to :user
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments
end
