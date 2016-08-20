class ResourceusagesController < ApplicationController
  def create
    resource_usage = ResourceUsage.build_object(usage_params)
    result = resource_usage.save
    if result
      content = "The resource '#{resource_usage.resource.name}' has been allocated."
    else
      content = render_to_string('shared/_error_messages', formats: [:html],
        layout: false, locals: { error_object: resource_usage})
    end
    render json: { content: content, result:result }
  end

  private
    def usage_params
      params.require(:usage).permit(:user_id, :vcon, :near, :near, :double_res,
        :from_hrs, :from_mins, :from_am_pm, :to_hrs, :to_mins, :to_am_pm, :date)
    end
end
