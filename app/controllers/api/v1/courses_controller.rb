class Api::V1::CoursesController < Api::V1::BaseApiController
  before_action :find_course, only: [:show, :update, :destroy]
  before_action :authenticate_request!

  def index
    courses = Course.all.page(params[:page])
    render json: { courses: courses }, status: 200
  end

  def show
    render json: { course: @course }, status: 200
    
  end

  def create
    course = Course.new(strong_params)
    if course.save
       render json: {
        message: t('.create_course'),
        course: course
      }, status: 200
    else
      render json: { message: course.errors }, status: 406
    end
  end

  def update
    @course.update(strong_params)
    if @course.save
       render json: {
        message: t('.update_course'),
        course: @course
      }, status: 200
    else
      render json: { message: @course.errors }, status: 406
    end
  end

  def destroy
    @course.destroy
    render json: { message: t('.destroy_course') }, status: 200
  end

  private
  def find_course
    @course = Course.find(params[:id])
  end
  def strong_params
    params.require(:courses).permit( :teacher_id, :student_id, :status)
  end
end
