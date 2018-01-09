class Api::V1::RegistrationsController < Api::V1::BaseApiController
  before_action :authenticate_request!, only: [:update]

  def create
    user = User.new(strong_params)
    if user.save
      render json: {
        message: t('.create_user'),
        data: {
          id: user.id,
          email: user.email,
          admin: user.admin,
          active: user.active,
          teacher: user.teacher,
          rate: user.rate,
          authentication_token: get_auth_token(user)
        }
      }, status: 200
    else
      render json: { message: user.errors }, status: 406
    end
  end

  def update
    user = current_user
    user.update(strong_params)
    if user.save
      render json: { message: t('.update_user') }, status: 200
    else
      render json: {message: user.errors }, status: 406
    end
  end

  private
  def strong_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end

end
