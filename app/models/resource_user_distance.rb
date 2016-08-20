class ResourceUserDistance < ApplicationRecord
  # VALIDATIONS
  validates :resource_id, :user_id, presence: true
  validates :distance, inclusion: { in: 1..50 }
  # ASSOCIATIONS
  belongs_to :user
  belongs_to :resource
end
