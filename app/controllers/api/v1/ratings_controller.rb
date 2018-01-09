class Api::V1::RatingsController < Api::V1::BaseApiController
  before_action :check_permission_rate, only: [ :create, :destroy]

  def create
    # delete old rating if exist
    old_rating = Rating.find_by(rater_id: current_user.id,rated_id:
      strong_params[:rated_id])
    old_rating.destroy if old_rating

    rating = Rating.new(strong_params.merge({ rater_id: current_user.id}))
    authorize rating

    if rating.save
      render json: {
        message: t('.create_rating'),
        rating: rating
      }, status: 200
    else
      render json: { message: rating.errors }, status: 406
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    authorize rating
    rating.destroy
    render json: { message: t('.destroy_rating') }, status: 200
  end

  private

  def check_permission_rate
    unless current_user.courses_as_students.where(teacher_id: strong_params[:rated_id])
      render json: { message: I18n.t('.dont_have_permission') }, status: 406
    end
  end

  def strong_params
    params.require(:ratings).permit( :rated_id, :rate, :comment)
  end
end
