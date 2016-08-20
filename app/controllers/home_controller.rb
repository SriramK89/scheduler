class HomeController < ApplicationController
  def index
    resource_usages = ResourceUsage.includes(:resource, :user)
    users = User.select('id, name').all
    render locals: {resource_usages: resource_usages, users: users}
  end
end
