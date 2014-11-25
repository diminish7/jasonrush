class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  respond_to :html, :json

  rescue_from Exception, with: :general_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

protected
  def general_error(exception)
    render json: { error: exception.message }, status: :internal_server_error
  end

  def record_not_found(exception)
    render json: { error: "Could not find the requested #{controller_name.singularize}" }, status: :not_found
  end

  def user_not_authorized(exception)
    render json: { error: "You are not authorized to perform this action" }, status: :unauthorized
  end
end
