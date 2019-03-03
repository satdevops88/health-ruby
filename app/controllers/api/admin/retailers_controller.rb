module Api
  module Admin
    class RetailersController < BaseController

      # GET /api/admin/retailers?filter=<string>
      def index
        if params[:filter].present?
          retailers = Retailer.where("name ILIKE ?", "%#{params[:filter]}%")
        else
          retailers = Retailer.all
        end

        render json: { retailers: retailers.map { |r| RetailerSerializer.new(r).serialize } }
      end
    end
  end
end