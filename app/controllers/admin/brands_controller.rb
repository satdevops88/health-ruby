module Admin
  class BrandsController < BaseController
    PAGE_SIZE = 100

    def edit
      @brand = Brand.find(params[:id])
    end

    # GET /admin/brands?page=<int>&per_page=<int>&search=<string>
    def index
      page = params[:page].present? ? params[:page].to_i : 1
      per_page = params[:per_page].present? ? params[:per_page].to_i : PAGE_SIZE
      offset = (page - 1) * per_page

      brand_clause = Brand.includes(:products).order(:name)

      if params[:search].present?
        brand_clause = brand_clause.where('name ILIKE ?', "%#{params[:search]}%")
      else
        brand_clause = brand_clause.all
      end

      @brands = brand_clause.offset(offset).limit(per_page)
      @pagination = {
        current_page: page,
        pages: (brand_clause.size / per_page) + 1,
        search_params: params.permit(:search)
      }
    end 
  
  end
end