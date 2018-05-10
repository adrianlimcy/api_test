# app/controllers/concerns/exception_handler.rb
module ExceptionHandler
  # provides the more graceful 'include' method
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches 'StandardErrors'
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({message: e.message}, :not_found)
    end
  end

  # rescue_from ActiveRecord::RecordInvalid do |e|
  #   json_response({message: e.message}, :unprocessable_entity)
  # end
  private

  #JSON respone with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({message: e.message}, :unprocessable_entity)
  end

  #JSON json_response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_response({message: e.message}, :unauthorized)
  end

end
