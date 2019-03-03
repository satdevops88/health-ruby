class Api::BaseController < ActionController::Base
  before_action :set_current_installation
  protect_from_forgery with: :null_session, unless: -> { params.dig(:event, :name) == :install.to_s }

  private

    def current_installation
      @current_installation
    end

    def set_current_installation
      identifier = request.headers['X-Chrome-Identity']
      if identifier.present?
        @current_installation = Installation.find_or_create_by(identifier: identifier)
      else
        @current_installation = nil
      end
    end
end
