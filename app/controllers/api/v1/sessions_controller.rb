class Api::V1::SessionsController < Api::V1::BaseApiController
  before_action :authencate_token!, only: :destroy
  def create
    @user = User.find_by_email( session_params[:email])

    if @user && @user.valid_password?( session_params[:password])
      @user.update(authentication_token: Devise.friendly_token)
      render json: {
        message: t('.sign_in_success'),
        data: { authentication_token: @user.authentication_token }
      }, status: 201
    else
      render json: { message: "Password or Email not match" }, status: 406
    end
  end

  def destroy
    if @user
      @user.update(authentication_token: nil)
      render json: { message: t('.sign_out_success') }, status: 200
    else
      render json: { message: t('.authentication_token_not_match') }, status: 406
    end
  end

  private
  def session_params
    params.require(:session).permit( :email, :password)
  end
end
