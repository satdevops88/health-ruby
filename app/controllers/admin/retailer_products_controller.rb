module Admin
  class RetailerProductsController < BaseController
    PAGE_SIZE = 100
    SEARCH_TYPE_ASIN = 'asin'
    SEARCH_TYPE_CATEGORY = 'category'
    SEARCH_TYPE_NAME = 'name'

    # GET /admin/retailer_products/:id/edit
    def edit
      @retailer_product = RetailerProduct.find(params[:id])
    end

    # GET /admin/retailer_products?page=<int>&per_page=<int>&search=<string>&search_type=<string>
    def index
      page = params[:page].present? ? params[:page].to_i : 1
      per_page = params[:per_page].present? ? params[:per_page].to_i : PAGE_SIZE
      offset = (page - 1) * per_page

      product_clause = RetailerProduct.includes(:recommended_products).order(:name)

      if params[:search].present?
        if params[:search_type] == SEARCH_TYPE_ASIN
          product_clause = product_clause.where(external_id: params[:search])
        elsif params[:search_type] == SEARCH_TYPE_CATEGORY
          category_ids = Category.where('name ILIKE ?', "%#{params[:search]}%").pluck(:id)
          product_clause = product_clause.where(category_id: category_ids)
        elsif params[:search_type] == SEARCH_TYPE_NAME
          product_clause = product_clause.where('name ILIKE ?', "%#{params[:search]}%")
        end
      else
        product_clause = product_clause.all
      end

      @retailer_products = product_clause.offset(offset).limit(per_page)
      @pagination = {
        current_page: page,
        pages: (product_clause.size / per_page) + 1,
        search_params: params.permit(:search, :search_type)
      }
    end

  end
end