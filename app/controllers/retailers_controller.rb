class RetailersController < ApplicationController
  # Allow 3rd parties to request scrape.js
  skip_before_action :verify_authenticity_token, only: [:scrape]

  # /retailers/scrape.js?url=
  def scrape
    # TODO - normalize url and save it, tied to unique extension user
    @retailer = 'amazon.com'
  end
end