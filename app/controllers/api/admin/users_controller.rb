module Api
  module Admin
    class UsersController < BaseController

      # DELETE /api/admin/users/:id
      def destroy
        user = User.find(params[:id])

        if user.destroy
          head 204
        else
          render json: { error: user.errors.full_messages }, status: 422
        end
      end

      # PATCH /api/admin/users/:id
      def update
        user = User.find(params[:id])
        parms = users_params
        parms.delete(:password) if parms.dig(:password).blank?
        user.update_attributes(parms)
        if user.errors.present?
          render json: { error: user.errors.full_messages }, status: 422
        else
          render json: { user: user.to_json }
        end
      end

      private

        def users_params
          params.require(:user).permit(:email, :password, :admin)
        end

    end
  end
end