class Api::V1::RatingsController < Api::V1::BaseApiController
  before_action :find_rating, only: [:destroy]
  before_action :authenticate_request!, except: :index

  # còn chưa làm logic cho rating , cần viết thêm service rating permission
  def index
    ratings = User.joins(:rateds).joins(:profile).where("ratings.id IN (?)", User.find(params[:profile_id]).rating_ids)
      .select('users.id,profiles.name, users.email, ratings.comment')
      .order("ratings.updated_at DESC").page(params[:page])

    render json: { ratings: ratings }, status: 200
  end

  def create
    # delete old rating if exist
    old_rating = Rating.find_by(rater_id: strong_params[:rater_id], rated_id: strong_params[:rated_id])
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

  def find_rating
    @rating = Rating.find(params[:id])
  end
  def strong_params
    params.require(:ratings).permit( :rater_id, :rated_id, :rate, :comment)
  end
end
