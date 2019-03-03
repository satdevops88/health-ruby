module Api
  module Admin
    class RetailerCategoriesController < BaseController

      # GET /api/admin/retailer_categories?filter=<string>
      def index
        if params[:filter].present?
          retailer_categories = RetailerCategory.where("full_name ILIKE ?", "%#{params[:filter]}%")
        else
          retailer_categories = RetailerCategory.all
        end

        render json: { retailer_categories: retailer_categories.map { |r| RetailerCategorySerializer.new(r).serialize } }
      end
    end
  end
end