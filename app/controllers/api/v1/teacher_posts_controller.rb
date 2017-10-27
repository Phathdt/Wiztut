class Api::V1::TeacherPostsController < Api::V1::BaseApiController
  before_action :find_tp, only: [:show, :update, :destroy]
  before_action :authenticate_request!, except: [:index, :show]

  def index
    tps = TeacherPost.all.page(params[:page])
    render json: { teacher_posts: tps }, status: 200
  end

  def show
    render json: { teacher_post: @tp }, status: 200
  end

  def create
    @tp = TeacherPost.new(strong_params.merge({ user_id: current_user.id}))
    authorize @tp
    if @tp.save
      render json: {
        message: t('.create_tp'),
        teacher_post: @tp
      }, status: 200
    else
      render json: { message: @tp.errors }, status: 406
    end
  end

  def update
    authorize @tp
    @tp.update(strong_params)
    if @tp.save
      render json: {
        message: t('.update_tp'),
        teacher_post: @tp
      }, status: 200
    else
      render json: { message: @tp.errors }, status: 406
    end
  end

  def destroy
    authorize @tp
    @tp.destroy
    render json: { message: t('.destroy_tp') }, status: 200
  end

  private

  def find_tp
    @tp = TeacherPost.find(params[:id])
  end
  
  def strong_params
    params.require(:teacher_posts).permit(
      :title, :grade, :subject, :time, :address, :salary, :cost, :note, :status
    )
  end
end
