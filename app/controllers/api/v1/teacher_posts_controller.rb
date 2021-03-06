class Api::V1::TeacherPostsController < Api::V1::BaseApiController
  before_action :find_tp, only: [:show, :update, :destroy]
  before_action :authenticate_request!, except: [:index, :show]

  def index
    @tps = TeacherPost.includes(:profile).active.order('created_at DESC').page(params[:page])
    @tps = @tps.search(params[:title].gsub(/%20/, ' ')) if search_params.present?

    if filter_params
      @tps = @tps.where(grade: filter_params[:grade]) if filter_params[:grade]
      @tps = @tps.where(subject: filter_params[:subject]) if filter_params[:subject]
      @tps = @tps.where('salary <= ?', filter_params[:salary]) if filter_params[:salary]
      @tps = @tps.where("? = ANY (address)",filter_params[:address]) if filter_params[:address]
    end
    render 'teacher_post/index'
  end

  def show
    render json: {
      teacher_post: @tp,
      profile_id: @tp.owner.id,
      profile_name: @tp.owner.name,
      avatar: @tp.owner.avatar
      }, status: 200
  end

  def create
    @tp = TeacherPost.new(strong_params.merge({ user_id: current_user.id}).to_h.compact)
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

  def search_params
    params.permit(:title)
  end

  def filter_params
    params.slice(:grade ,:subject ,:address ,:salary)
  end
end
