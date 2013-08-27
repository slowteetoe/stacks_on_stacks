class ProfilesController < ApplicationController

  before_action :authenticate_user!

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to current_user, notice: 'Profile was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:display_name, :gravatar_email, :tagline, :reputation)
  end

end
