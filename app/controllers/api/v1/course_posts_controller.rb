class Api::V1::CoursePostsController < Api::V1::BaseApiController
  before_action :find_cp, only: [:show, :update, :destroy]
  before_action :authenticate_request!, except: [:index, :show]


  def index
    @cps = CoursePost.active.includes(:profile).order('created_at DESC').page(params[:page])
    @cps = @cps.search(params[:title]) if params[:title]
    render 'course_post/index'
  end

  def show
    render json: {
      course_post: @cp,
      profile_id: @cp.owner.id,
      profile_name: @cp.owner.name
      }, status: 200
  end

  def create
    @cp = CoursePost.new(strong_params.merge({ user_id: current_user.id}).to_h.compact)
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

  def search_params
    params.permit(:title)
  end
end
