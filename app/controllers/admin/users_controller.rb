module Admin
  class UsersController < BaseController
    PAGE_SIZE = 100

    def edit
      @user = User.find(params[:id])
    end

    # GET /admin/users?page=<int>&per_page=<int>&search=<string>
    def index
      page = params[:page].present? ? params[:page].to_i : 1
      per_page = params[:per_page].present? ? params[:per_page].to_i : PAGE_SIZE
      offset = (page - 1) * per_page

      user_clause = User.order(:id).all

      
      user_clause = user_clause.where('email ILIKE ?', "%#{params[:search]}%") if params[:search].present?

      @users = user_clause.offset(offset).limit(per_page)
      @pagination = {
        current_page: page,
        pages: (user_clause.size / per_page) + 1,
        search_params: params.permit(:search)
      }
    end 
  
  end
end