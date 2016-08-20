class Resource < ApplicationRecord
  # VALIDATIONS
  validates :pair_resource_id, uniqueness: true, allow_blank: true
  validates :name, uniqueness: { case_sensitive: false }
  # ASSOCIATIONS
  has_many :user_distances, foreign_key: :resource_id, class_name: "ResourceUserDistance"
  has_many :usages, foreign_key: :resource_id, class_name: "ResourceUsage"
  # has_one :pair_resource, foreign_key: :pair_resource_id, class_name: "Resource"
  # belongs_to :other_pair_resource, inverse_of: :pair_resource
  def pair
    Resource.where(id: pair_resource_id).first
  end

  def other_pair
    Resource.where(pair_resource_id: id).first
  end
end
