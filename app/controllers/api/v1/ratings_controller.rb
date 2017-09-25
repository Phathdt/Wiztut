class Api::V1::RatingsController < Api::V1::BaseApiController
  before_action :find_rating, only: [:destroy]
  before_action :check_permission_rate, only: [ :create, :destroy]

  def create
    # delete old rating if exist
    old_rating = Rating.find_by(rater_id: strong_params[:rater_id],
                                rated_id: strong_params[:rated_id])
    old_rating.destroy if old_rating.nil?

    rating = Rating.new(strong_params)
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
    @rating.destroy
    render json: { message: t('.destroy_rating') }, status: 200
  end

  private

  def check_permission_rate
    unless current_user.courses_as_students.pluck(:teacher_id).include?(strong_params[:rater_id])
      render json: { message: I18n.t('.dont_have_permission') }, status: 406
    end
  end

  def find_rating
    @rating = Rating.find(params[:id])
  end

  def strong_params
    params.require(:ratings).permit( :rater_id, :rated_id, :rate, :comment)
  end
end
