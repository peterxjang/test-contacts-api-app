class GroupsController < ApplicationController
  def index
    groups = Group.all
    render json: groups.as_json
  end
end
