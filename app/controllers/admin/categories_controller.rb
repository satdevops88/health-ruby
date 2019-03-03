module Admin
  class CategoriesController < BaseController
    PAGE_SIZE = 100

    def edit
      @category = Category.find(params[:id])
    end

    # GET /admin/categories?page=<int>&per_page=<int>&search=<string>
    def index
      page = params[:page].present? ? params[:page].to_i : 1
      per_page = params[:per_page].present? ? params[:per_page].to_i : PAGE_SIZE
      offset = (page - 1) * per_page

      category_clause = Category.includes(:retailer_categories).order(:name)

      if params[:search].present?
        category_clause = category_clause.where('name ILIKE ?', "%#{params[:search]}%")
      else
        category_clause = category_clause.all
      end

      @categories = category_clause.offset(offset).limit(per_page)
      @pagination = {
        current_page: page,
        pages: (category_clause.size / per_page) + 1,
        search_params: params.permit(:search)
      }
    end 
  
  end
end