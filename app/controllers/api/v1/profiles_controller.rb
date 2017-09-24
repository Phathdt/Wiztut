class Api::V1::ProfilesController < Api::V1::BaseApiController
  def create
    profile = current_user.build_profile(strong_params)
    if profile.save
      render json: {
        message: t('.create_profile'),
        profile: profile
      }, status: 200
    else
      render json: { message: profile.errors }, status: 406
    end
  end

  def update
    profile = current_user.profile
    profile.update(strong_params)
    if profile.save
      render json: {
        message: t('.update_profile'),
        profile: profile
      }, status: 200
    else
      render json: { message: profile.errors }, status: 406
    end
  end

  private
  def strong_params
    params.require(:profiles).permit(
      :name, :dob, :sex, :school, :degree, :graduation_year, :salary,
      :about_me, :phone, :grades, :subjects
    )
  end
end
