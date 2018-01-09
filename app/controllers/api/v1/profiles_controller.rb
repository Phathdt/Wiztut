class Api::V1::ProfilesController < Api::V1::BaseApiController
  before_action :authenticate_request!

  def index
    users = User.includes(:profile).order(rate: :desc).page(params[:page])
    users = users.search(params[:name].gsub(/%20/, ' '), current_user) if params[:name].present?
    if filter_params
      users = users.joins(:profile)
      users = users.where('profiles.sex' => filter_params[:sex]) if filter_params[:sex]
      users = users.where('profiles.salary <= ?', filter_params[:salary]) if filter_params[:salary]
      users = users.where('profiles.degree' => filter_params[:degree]) if filter_params[:degree]
      users = users.where(teacher: filter_params[:teacher]) if filter_params[:teacher]
    end

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

    can_rating = if current_user == user
      false
    else
      user.courses_as_teachers.where(status: 1).pluck(:student_id).include? current_user.id
    end

    render json: {
      user_id: user.id,
      profile: profile,
      email: user.email,
      avatar: profile.avatar.url,
      rate:    user.ratings.average(:rate).to_i,
      can_rating: can_rating,
      courses:  Course.get_your_course(current_user.id).limit(5).collect.with_index do |c, index|
        {
          id: index + 1,
          name: c.name,
          role: c.role(current_user.id)
        }
      end,
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

  def toggle
    current_user.toggle(:teacher)
    current_user.save
    render json: { message: I18n.t('profile.toggle') }, status: 200
  end

  private
  def strong_params
    params.require(:profiles).permit(
      :name, :dob, :sex, :school, :degree, :graduation_year, :salary,
      :about_me, :phone, :grades, :subjects, :avatar
    )
  end

  def filter_params
    params.slice(:sex, :salary, :degree, :teacher)
  end
end
