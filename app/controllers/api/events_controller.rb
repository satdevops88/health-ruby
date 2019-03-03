class Api::EventsController < Api::BaseController

  # /api/events
  def create
    attrs = event_params
    if attrs[:categories].is_a?(Array)
      attrs[:categories] = attrs[:categories].join(' > ')
    end
    event = Event.create({ installation: @current_installation }.merge(attrs))

    if event.persisted?
      render json: {}
    else
      # TODO - render a real error. Not needed for current use as client just
      # sends request and does nothing with the response right now
      render json: {} 
    end
  end

  private

    def event_params
      params.require(:event).permit(:external_id, :name, :product_id, :retailer, :categories => [])
    end
end