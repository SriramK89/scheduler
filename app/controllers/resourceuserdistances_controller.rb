class ResourceuserdistancesController < ApplicationController
  def index
    resource_user_distances = ResourceUserDistance.includes(:user, :resource).all
    render locals: {resource_user_distances: resource_user_distances}
  end
end
