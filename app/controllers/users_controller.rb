class UsersController < ApplicationController

  before_action :authenticate_user!

	def show
		@user = User.find(params[:id])
	end

	def index
		@users = User.order_by(:created_at.desc).page(params[:page]).per(20)
	end

end