module Api
  module Admin
    class ProductsController < BaseController

      # POST /api/admin/products
      # Can be sent just an ASIN or all fields
      def create
        if product_params.keys == ['asin']
          aws_product = Amazon::RemoteProduct.find_by_asin(product_params[:asin])
          product = Product.create_from_remote_product(aws_product)
        else
          product = Product.create(product_params)
        end

        if product.persisted?
          render json: { product: ProductSerializer.new(product).serialize }, status: 201
        else
          render json: { error: product.errors.full_messages }, status: 422
        end
      end

      # DELETE /api/admin/products/:id
      def destroy
        if params[:id].is_a?(String) && params[:id].include?(',')
          products = Product.where(id: params[:id].split(','))
        else
          products = Product.where(id: params[:id])
        end

        if products.destroy_all
          head 204
        else
          render json: { error: '' }, status: 422
        end
      end

      # PATCH /api/admin/products/:id
      def update
        product = Product.find(params[:id])
        ActiveRecord::Base.transaction do
          params[:product][:categories].each do |category|
            if !category[:_delete]
              c = Category.find_or_create_by(name: category[:name])
              product.categories << c unless product.categories.include?(c)
            else
              c = Category.find_by(name: category[:name])
              product.product_categories.find_by(category_id: c.id).try(:destroy)
            end
          end

          product.update_attributes(product_params)
        end

        render json: { product: ProductSerializer.new(product).serialize }
      end

      private

        def product_params
          params.require(:product).permit(:amazon_price, :asin, :image_src, :name, :price, :teaser)
        end

    end
  end
end