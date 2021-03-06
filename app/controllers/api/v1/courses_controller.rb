class Api::V1::CoursesController < Api::V1::BaseApiController
  before_action :authenticate_request!
  before_action :find_course, only: [:show, :update, :destroy]

  def index
    courses = Course.get_your_course(current_user.id).order(updated_at: :desc).page(params[:page])
    render json: {
      courses: courses.collect do |c|
        {
          id: c.id,
          teacher: c.teacher.name,
          teacher_id: c.teacher.id,
          student: c.student.name,
          status: CONFIG.dig("course_status", c.status)
        }
      end
    }, status: 200
  end

  def show
    c = @course
    render json: {
      id: c.id,
      teacher_id: c.teacher_id,
      teacher_name: c.teacher.name,
      student_id: c.student_id,
      student_name: c.student.name,
      status: CONFIG.dig("course_status", c.status)
    }, status: 200
  end

  def create
    course = Course.new(strong_params.merge({ student_id: current_user.id}))
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
    authorize @course
    if  params.dig(:courses, :status) == 'success'
      @course.status = 'success'
    else
      @course.status = 'canceled'
    end
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
    authorize @course
    @course.destroy
    render json: { message: t('.destroy_course') }, status: 200
  end

  private

  def check_permission_for_course
    is_student = @course.student_id == current_user.id
    is_teacher = @course.teacher_id == current_user.id

    if (is_student || is_teacher)
      render json: { message: I18n.t('.dont_have_permission') }, status: 406 if (action_name == "update" && is_student)
    else
      render json: { message: I18n.t('.dont_have_permission') }, status: 406
    end
  end

  def find_course
    @course = Course.find(params[:id])
  end
  def strong_params
    params.require(:courses).permit( :teacher_id, :name, :status)
  end
end
