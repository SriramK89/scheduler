class ResourceusagesController < ApplicationController
  def index
    checked_params = loading_usages_monday_params
    monday = Time.zone.parse(checked_params[:from_date]).to_datetime
    resource_usages = ResourceUsage.includes(:resource, :user).where(from_time: ((monday.to_i)..((monday + 4.days).to_i)))
    content = render_to_string('index', formats: [:html],
      layout: false, locals: { resource_usages: resource_usages, monday: monday })
    render json: { content: content }
  end

  def create
    resource_usage = ResourceUsage.build_object(usage_params)
    result = resource_usage.save
    if result
      content = "The resource '#{resource_usage.resource.name}' has been allocated."
    else
      content = render_to_string('shared/_error_messages', formats: [:html],
        layout: false, locals: { error_object: resource_usage })
    end
    render json: { content: content, result: result }
  end

  private
    def usage_params
      params.require(:usage).permit(:user_id, :vcon, :near, :near, :double_res,
        :from_date, :to_date)
    end

    def loading_usages_monday_params
      params.require(:date).permit(:from_date)
    end
end
