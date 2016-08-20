class User < ApplicationRecord
  # VALIDATIONS
  validates :name, uniqueness: { case_sensitive: false }
  validates :priority, :inclusion => 1..5, on: [:create, :update]
  # ASSOCIATIONS
  has_many :resource_distances, foreign_key: :user_id, class_name: "ResourceUserDistance"
  has_many :usages, foreign_key: :user_id, class_name: "ResourceUsage"
end
