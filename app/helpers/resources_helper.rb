module ResourcesHelper
  def get_pair_resource resource
    if resource.pair_resource_id
      resource.pair.name
    else
      other_pair = resource.other_pair
      if other_pair
        other_pair.name
      end
    end
  end
end
