module Api
  module Admin
    class RetailerProductsController < BaseController

      # POST /api/admin/retailer_products
      def create
        aws_product = Amazon::RemoteProduct.find_by_asin(retailer_product_params[:external_id])
        # TODO - needs to update when expanding beyond Amazon
        retailer = Retailer.find_or_create_by(name: Retailer::RETAILER_NAME_AMAZON)
        retailer_product = RetailerProduct.find_or_create_by(retailer: retailer, external_id: retailer_product_params[:external_id], name: aws_product.name)

        if retailer_product.persisted?
          render json: { retailer_product: RetailerProductSerializer.new(retailer_product).serialize }, status: 201
        else
          render json: { error: retailer_product.errors.full_messages }, status: 422
        end
      end

      # DELETE /api/admin/retailer_products/:id
      def destroy
        retailer_product = RetailerProduct.find(params[:id])

        if retailer_product.destroy
          head 204
        else
          render json: { error: retailer_product.errors.full_messages }, status: 422
        end
      end

      # PATCH /api/admin/retailer_products/:id
      def update
        retailer_product = RetailerProduct.find(params[:id])
        ActiveRecord::Base.transaction do
          params[:retailer_product][:recommended_products].each do |product|
            p = Product.find_by(asin: product[:asin])
            if !product[:_delete]
              if !p
                aws_product = Amazon::RemoteProduct.find_by_asin(product[:asin])
                p = Product.create_from_remote_product(aws_product)
              end
              retailer_product.recommended_products << p unless retailer_product.recommended_products.include?(p)
            else
              retailer_product.retailer_product_products.find_by(product_id: p.id).try(:destroy)
            end
          end

          retailer_product.update_attributes(retailer_product_params)
        end

        render json: { retailer_product: RetailerProductSerializer.new(retailer_product).serialize }
      end

      private

        def retailer_product_params
          params.require(:retailer_product).permit(:external_id, :name)
        end

    end
  end
end