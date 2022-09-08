class ApplicationController < ActionController::API
  rescue_from(StandardError, with: :render_internal_error_response)
  rescue_from(ArgumentError, with: :render_bad_request_response)
  rescue_from(ActionController::ParameterMissing, with: :render_missing_parameter_response)
  rescue_from(ActionController::BadRequest, with: :render_bad_request_response)
  rescue_from(ActiveRecord::RecordInvalid, with: :render_record_invalid_response)
  rescue_from(ActiveRecord::RecordNotFound, with: :render_not_found_response)

  private

  def render_internal_error_response(error)
    render(json: { errors: [{ detail: 'Internal Server Error' }] }, status: :internal_server_error)
  end

  def render_bad_request_response(error)
    render(json: { errors: [{ detail: "Bad request: #{error.message}" }] }, status: :bad_request)
  end

  def render_not_found_response
    render(json: { message: { errors: [{ detail: 'Record not found' }] } }, status: :not_found)
  end

  def render_record_invalid_response(object)
    errors = object.record.errors.to_hash(full_messages: true).map do |field, field_errors|
      field_errors.map do |error_message|
        {
          source: { pointer: "/data/attributes/#{field}" },
          detail: error_message
        }
      end
    end.flatten

    render(json: { message: { errors: errors } }, status: :unprocessable_entity)
  end

  def render_missing_parameter_response(error)
    errors = [{ source: { pointer: "/data/attributes/#{error.param}" }, detail: "#{error.param.capitalize} can't be blank" }]

    render(json: { message: { errors: errors } }, status: :unprocessable_entity)
  end
end
