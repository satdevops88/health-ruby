module Api
  module Admin
    class BrandsController < BaseController

      # DELETE /api/admin/brands/:id
      def destroy
        brand = Brand.find(params[:id])

        if brand.destroy
          head 204
        else
          render json: { error: brand.errors.full_messages }, status: 422
        end
      end

      # PATCH /api/admin/brands/:id
      def update
        brand = Brand.find(params[:id])
        brand.update_attributes(brands_params)

        render json: { category: BrandSerializer.new(brand).serialize }
      end

      private

        def brands_params
          params.require(:brand).permit(:name)
        end

    end
  end
end