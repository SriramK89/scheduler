class HomeController < ApplicationController
  def index
    users = User.select('id, name').all
    render locals: { users: users }
  end
end
