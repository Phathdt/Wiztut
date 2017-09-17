class Api::V1::RegistrationsController < Api::V1::BaseApiController
  before_action :authenticate_request!, only: [:update]

  def create
    user = User.new(strong_params)
    if user.save
      render json: { auth_token: get_auth_token(user)}, status: 201
    else
      render json: { message: user.errors }, status: 406
    end
  end

  def update
    user = current_user 
    user.update(strong_params)
    if user.save
      render json: {user: user}, status: 200
    else
      render json: {message: "FAIL"}, status: 400
    end
  end

  private
  def strong_params
    params.require( :registration).permit( :email, :password, :password_confirmation)
  end

  def get_auth_token(user)
    Authenticate::JsonWebToken.encode({user_id:user.id})
  end
  # def create
  #   @user = User.new(registration_params)

  #   if @user.save
  #     render json: {
  #       message: t('.create_user') ,
  #       data: { authentication_token: @user.authentication_token }
  #     }, status: 201
  #   else
  #     render json: { message: @user.errors }, status: 406
  #   end

  # end

  # def update
  #   render json: { message: t('.wrong_token') }, status: 401 unless @user
  #   @user.update(registration_params)
  #   if @user.save
  #     render json: { message: t('.update_user') , user: @user}, status: 200
  #   else
  #     render json: { message: @user.errors }, status: 406
  #   end
  # end
end
