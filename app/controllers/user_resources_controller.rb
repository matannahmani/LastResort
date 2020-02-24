class UserResourcesController < ApplicationController
  def index
    @user_resources = UsersController.all
  end

  def update
  end
end
