class Api::V1::ProfilesController < Api::V1::BaseApiController
  before_action :authenticate_request!, except: [:index]

  def index
    # users = User.all.order(rate: :desc).includes(:profile).page(params[:page]).joins(:profile)
    users = User.where(teacher: true).joins(:profile).select(:id, :name, :school, :degree, :rate).order(rate: :desc).page(params[:page])
    render json: {
      users: users
    }, status: 200
  end

  def show
    user = User.joins(:profile).find(params[:id])
    profile = user.profile
    rate = user.rate
    ratings = User.joins(:rateds).joins(:profile).where("ratings.id IN (?)", user.rating_ids)
    .select('users.id,profiles.name, users.email, ratings.comment')
    can_rating = user.courses_as_teachers.pluck(:student_id).include? current_user.id
    render json: {
      profile: profile,
      rate: rate,
      ratings: ratings,
      can_rating: can_rating
    }, status: 200
  end

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
