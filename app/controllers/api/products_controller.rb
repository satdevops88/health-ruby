class Api::ProductsController < Api::BaseController
  PAGE_SIZE = 10

  # GET /api/products?filter=<string>&page=<int>&per_page=<int>
  def index
    page = params[:page].present? ? params[:page].to_i : 1
    per_page = params[:per_page].present? ? params[:per_page].to_i : PAGE_SIZE
    offset = (page - 1) * per_page

    if params[:filter].present?
      #record_event(Event::EVENT_SEARCH) # don't send for now, app sends 4 times :/
      category_ids = Category.where('name ILIKE ?', "%#{params[:filter]}%").pluck(:id)
      products = Product.joins(:categories).where('products.name ILIKE ? OR categories.id IN (?)', "%#{params[:filter]}%", category_ids).offset(offset).limit(per_page)
    else
      products = Product.all.offset(offset).limit(per_page)
    end

    render json: { products: products.map { |p| ProductSerializer.new(p).serialize } }
  end

  private 

    def record_event(event)
      if params[:retailer].present? # right now only record amazon searches (not searches in extension) because the extension for some reason loads 10+ pages everytime you search
        Event.create(
          categories: nil, # no category
          subject: params[:filter],
          page_number: params[:page],
          name: event,
          retailer: params[:retailer] || "Healthiest", # TEMP until new version goes out
          installation: current_installation
        )
      end
    end

end