class Api::V1::CoursePostsController < Api::V1::BaseApiController
  before_action :find_cp, only: [:show, :update, :destroy]
  before_action :authenticate_request!, except: [:index, :show]


  def index
    cps = CoursePost.all.page(params[:page])
    render json: { course_posts: cps }, status: 200
  end

  def show
    render json: { course_post: @cp }, status: 200
  end

  def create
    @cp = CoursePost.new(strong_params.merge({ user_id: current_user.id}))
    authorize @cp
    if @cp.save
      render json: {
        message: t('.create_cp'),
        course_post: @cp
      }, status: 200
    else
      render json: { message: @cp.errors }, status: 406
    end
  end

  def update
    authorize @cp
    @cp.update(strong_params)
    if @cp.save
      render json: {
        message: t('.update_cp'),
        course_post: @cp
      }, status: 200
    else
      render json: { message: @cp.errors }, status: 406
    end
  end

  def destroy
    authorize @cp
    @cp.destroy
    render json: { message: t('.destroy_cp') }, status: 200
  end


  private
  def find_cp
    @cp = CoursePost.find(params[:id])
  end

  def strong_params
    params.require(:course_posts).permit(
      :title, :grade, :subject, :time,:address, :real_address, :salary,
      :sex_require, :degree_require, :note, :status, :phone, :frequency
    )
  end
end
