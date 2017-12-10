class Api::V1::ProfilesController < Api::V1::BaseApiController
  before_action :authenticate_request!

  def index
    users = User.includes(:profile).order(rate: :desc).page(params[:page])
    users = users.search(params["name"], current_user) if params["name"]
    render json: {
      users: users.collect do |u|
        {
          id:     u.id,
          name:   u.profile&.name,
          avatar: u.profile&.avatar&.url,
          school: u.profile&.school,
          degree: u.profile&.degree,
          about_me: u.profile&.about_me,
          is_teacher: u.teacher?,
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
      avatar: profile.avatar.url,
      rate:    user.rate,
      can_rating: can_rating,
      is_teacher: user.teacher?,
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
    profile = current_user.profile || current_user.build_profile(strong_params)

    if profile.new_record?
      if profile.save
        render json: {
          message: t('.create_profile'),
          user_id: profile.user.id,
          profile: profile
        }, status: 200
      else
        render json: { message: profile.errors }, status: 406
      end
    else
      render json: { errors: I18n.t('profile.has_present') }, status: 406
    end
  end

  def update
    profile = current_user.profile
    authorize profile
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
      :about_me, :phone, :grades, :subjects, :avatar
    )
  end

  def filter_params
    params.slice(:sex, :salary)
  end
end
