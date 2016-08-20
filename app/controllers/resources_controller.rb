class ResourcesController < ApplicationController
  def index
    resources = Resource.all
    render locals: {resources: resources}
  end
end
