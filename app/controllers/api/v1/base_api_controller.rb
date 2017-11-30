class Api::V1::BaseApiController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_permission
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :authenticate_request!
  attr_reader :current_user

  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: I18n.t('.not_authenticated')}, status: :unauthorized
      return
    end

    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: I18n.t('.not_authenticated') }, status: :unauthorized
  end

  private
  def http_token
    @http_token ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    @auth_token ||= Authenticate::JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id]
  end

  def get_auth_token(user)
    Authenticate::JsonWebToken.encode({user_id:user.id, email: user.email})
  end

  def user_not_permission(exception)
    policy_name = exception.policy.class.to_s.underscore
    render json: { errors: I18n.t("#{policy_name}.#{exception.query}", scope: "pundit", default: :default) }, status: 406
  end

  def record_not_found
    render json: { errors: I18n.t('.record_not_found') }, status: 404
  end
end
