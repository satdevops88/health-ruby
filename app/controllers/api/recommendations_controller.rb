class Api::RecommendationsController < Api::BaseController

  REAL_TIME_LOOKUP = ENV["REAL_TIME_LOOKUP"].present? ? ENV["REAL_TIME_LOOKUP"].try(:downcase) == "true" : true

  # /api/recommendations?categories[]=<string>&retailer=<string>
  def index
    if params[:category].present?
      params[:categories] = params[:category].split(',')
    end

    record_event(Event::EVENT_PAGE_VIEW)
    recommendations_service = RecommendationsService.new(
      categories: params[:categories],
      external_id: params[:external_id],
      retailer: params[:retailer]
    )

    if recommendations_service.products.any?
      record_event(Event::EVENT_DISPLAY)
      if REAL_TIME_LOOKUP && params[:retailer].try(:downcase) == :Amazon.to_s.downcase
        rt_productinfo = Amazon::RemoteProduct.find_items(asins: recommendations_service.products.map(&:asin))
        rt_productinfo.each do |k,rt_p|
          recommendations_service.products.detect{|rs_p| rs_p.asin.try(:downcase) == k.try(:downcase)}.amazon_price = rt_p.price
        end
      end
      render json: {
        category: {
          name: recommendations_service.retailer_category_name
        },
        is_recommended: recommendations_service.retailer_product_is_recommended?,
        products: recommendations_service.products.map { |p| ProductSerializer.new(p).serialize }
      }
    else
      # TODO - error message
      Rails.logger.error "#{self.class.to_s}##{__method__.to_s} no recommendations found for ASIN: #{params[:external_id]}"
      render json: { category: {}, products: [] }
    end
  end

  private

    def record_event(event)
      Event.create(
        categories: params[:categories].join(' > '),
        external_id: params[:external_id],
        name: event,
        retailer: params[:retailer],
        installation: current_installation
      )
    end

end
