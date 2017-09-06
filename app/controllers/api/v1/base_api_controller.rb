class Api::V1::BaseApiController < ActionController::Base
  private
  def authencate_token!
    @user = User.find_by(authentication_token: params[:authentication_token])
  end

end
