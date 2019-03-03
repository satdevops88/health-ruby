module Admin
  class EventsController < BaseController
    PAGE_SIZE = 100

    def edit
      @event = Event.find(params[:id])
    end

    # GET /admin/events?page=<int>&per_page=<int>&search=<string>
    def index
      page = params[:page].present? ? params[:page].to_i : 1
      per_page = params[:per_page].present? ? params[:per_page].to_i : PAGE_SIZE
      offset = (page - 1) * per_page

      event_clause = Event.order(id: :desc).all

      event_clause = event_clause.where(installation_id: params[:installation_id]) if params[:installation_id].present?
      event_clause = event_clause.where('name ILIKE ?', "%#{params[:search]}%") if params[:search].present?

      @events = event_clause.offset(offset).limit(per_page)
      @pagination = {
        current_page: page,
        pages: (event_clause.size / per_page) + 1,
        search_params: params.permit(:search)
      }
    end 
  
  end
end