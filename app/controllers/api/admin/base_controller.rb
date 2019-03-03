class Api::Admin::BaseController < ActionController::Base
  # TODO - grab current user from some sort of token. Just uses session currently for XHR requests
  before_action :require_admin!

  private

    def require_admin!
      if !current_user || !current_user.admin
        render json: { error: 'Not authorized' }, status: 401
      end
    end

end
