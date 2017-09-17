class Api::V1::SessionsController < Api::V1::BaseApiController
  before_action :authenticate_request!, only: :destroy
  def create
    user = User.find_by_email( strong_params[:email])

    if user && user.valid_password?( strong_params[:password])

      render json: {
        message: t('.sign_in_success'),
        data: { authentication_token: get_auth_token(user) }
      }, status: 201
    else
      render json: { message: t('.sign_in_fail') }, status: 406
    end
  end

  def destroy
    render json: { message: t('.sign_out_success') }, status: 200
  end

  private
  def strong_params
    params.require(:session).permit( :email, :password)
  end
end
