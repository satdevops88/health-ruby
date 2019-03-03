module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate_user!
    before_action :require_admin!

    private

      def require_admin!
        if !current_user.admin?
          redirect_to :root_path
        end
      end
  end
end