class Event < ApplicationRecord
  belongs_to :installation, optional: true

  EVENT_ADD_TO_CART = 'add_to_cart'
  EVENT_CLICK = 'click'
  EVENT_CLICK_RECOMMENDATION = 'click_recommendation'
  EVENT_DISPLAY = 'display'
  EVENT_INSTALL = 'install'
  EVENT_PAGE_VIEW = 'page_view'
  EVENT_SEARCH = 'search'

  validate :no_duplicate_install_event, on: :create

  private

    def no_duplicate_install_event
      if self.name == EVENT_INSTALL && Event.exists?(name: EVENT_INSTALL, installation_id: installation_id)
        errors.add(:name, "Install event already recorded")
      end
    end
end