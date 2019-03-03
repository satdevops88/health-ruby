module Api
  module Admin
    class CategoriesController < BaseController

      # POST /api/admin/categories
      def create
        category = Category.create(category_params)

        if category.persisted?
          render json: { category: CategorySerializer.new(category).serialize }, status: 201
        else
          render json: { error: category.errors.full_messages }, status: 422
        end
      end

      # DELETE /api/admin/categories/:id
      def destroy
        category = Category.find(params[:id])

        if category.destroy
          head 204
        else
          render json: { error: category.errors.full_messages }, status: 422
        end
      end

      # GET /api/admin/categories?filter=<string>
      def index
        if params[:filter].present?
          categories = Category.where("name ILIKE ?", "%#{params[:filter]}%")
        else
          categories = Category.all
        end

        render json: { categories: categories.map { |r| CategorySerializer.new(r).serialize } }
      end

      # PATCH /api/admin/categories/:id
      def update
        category = Category.find(params[:id])
        ActiveRecord::Base.transaction do
          params[:category][:retailer_categories].each do |retailer_category|
            if !retailer_category[:_delete]
              retailer = Retailer.find_or_create_by(name: retailer_category[:retailer])
              rc = RetailerCategory.find_or_create_from_tree(retailer_category[:tree], healthiest_category: category, retailer: retailer)
            else
              retailer = Retailer.find_by(name: retailer_category[:retailer])
              rc = RetailerCategory.find_from_tree(retailer_category[:tree], retailer: retailer)
              rc.try(:destroy)
            end
          end

          category.update_attributes(category_params)
        end

        render json: { category: CategorySerializer.new(category).serialize }
      end

      private

        def category_params
          params.require(:category).permit(:name)
        end

    end
  end
end