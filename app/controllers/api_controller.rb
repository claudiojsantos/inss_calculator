class ApiController < ActionController::API
  before_action :underscore_params!
  before_action :authenticate_request

  rescue_from ActionController::ActionControllerError, with: :render_action_controller_error
  rescue_from ActiveRecord::ActiveRecordError, with: :render_active_record_error
  rescue_from StandardError, with: :render_internal_server_error

  private

  def authenticate_request(respond_401 = true)
    @current_user = AuthorizeApiRequest.call(request.headers).result

    render json: { error: 'Not Authorized' }, status: 401 if respond_401 && !@current_user
  end

  def render_action_controller_error(exception)
    render_error('Action Controller Error', :unprocessable_entity, exception)
  end

  def render_internal_server_error(exception)
    render_error('Internal Server Error', :unprocessable_entity, exception)
  end

  def render_active_record_error(exception)
    render_error('Database Error', :unprocessable_entity, exception)
  end

  def render_error(error, status, exception = nil)
    return if performed?

    error_response = { error: error.is_a?(Array) ? error : [ error ] } # Ensure error is an array

    if exception
      message = "#{exception.class}: #{exception.message.gsub(/\n/, ' ')}"
      error_response[:message] = message

      if Rails.env.development?
        error_response[:details] = exception.details if exception.respond_to?(:details) && exception.details.present?
        error_response[:backtrace] = exception.backtrace.take(10) if exception.backtrace.is_a?(Array) && exception.backtrace.present?
      end

      Rails.logger.error message
      Rails.logger.error exception.backtrace.join("\n") if exception.backtrace
    end

    render json: error_response, status: status
  end

  def underscore_params!
    params.deep_transform_keys! { |key| key.to_s.underscore }
  end
end
