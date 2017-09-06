class Api::V1::RegistrationsController < Api::V1::BaseApiController
  before_action :authencate_token!, only: [:update, :destroy]
  def create
    @user = User.new(registration_params)

    if @user.save
      render json: {
        message: "Create User",
        data: { authentication_token: @user.authentication_token }
      }, status: 201
    else
      render json: { message: @user.errors }, status: 406
    end

  end

  def update
    render json: { message: "Wrong Token"}, status: 401 unless @user
    @user.update(registration_params)
    if @user.save
      render json: { message: "Update User", user: @user}, status: 200
    else
      render json: { message: @user.errors }, status: 406
    end
  end

  def destroy
    @user.delete

    render json: { message: "Delete User" }, status: 200
  end

  private
  def registration_params
    params.require( :registration).permit( :email, :password, :password_confirmation)
  end
end
