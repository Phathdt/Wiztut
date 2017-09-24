class Api::V1::RatingsController < Api::V1::BaseApiController
  before_action :find_rating, only: [:destroy]
  before_action :authenticate_request!, except: :index

  # còn chưa làm logic cho rating , cần viết thêm service rating permission
  def index
    #  can them code chỉ chọn những rating của mình thôi , order by ... 
    ratings = Rating.all.page(params[:page])
    render json: { ratings: ratings }, status: 200
  end

  def create
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
