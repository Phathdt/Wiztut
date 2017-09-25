class Api::V1::ProfilesController < Api::V1::BaseApiController
  before_action :authenticate_request!, except: [:index]

  def index
    users = User.includes(:profile).order(rate: :desc).page(params[:page])
    render json: {
      users: users.collect do |u|
        {
          id:     u.id,
          name:   u.profile.name,
          school: u.profile.school,
          degree: u.profile.degree,
          rate:   u.rate
        }
      end
    }, status: 200
  end

  def show
    user = User.find(params[:id])
    profile = user.profile

    ratings = Rating.joins("INNER JOIN profiles ON ratings.rater_id = profiles.user_id")
    .where(rated_id:params[:id]).includes(:rater).select('ratings.id, ratings.comment,
      ratings.rater_id, profiles.name as name, ratings.rate')
    .order(created_at: :DESC ).page(params[:page])
    
    can_rating = user.courses_as_teachers.pluck(:student_id).include? current_user.id
    render json: {
      profile: profile,
      rate:    user.rate,
      can_rating: can_rating,
      ratings: ratings.collect do |r|
      {
        id:      r.rater_id,
        name:    r.name,
        email:   r.rater.email,
        comment: r.comment,
        rate:    r.rate
      }
      end
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
