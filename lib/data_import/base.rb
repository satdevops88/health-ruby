module DataImport
  class Base
    # Add logging, etc. here

    def initialize(input)
      @input = input
    end

    def create_local_records(amazon_product)
      Product.create_from_remote_product(amazon_product)
    end

    def self.import(input)
      self.new(input).run
    end
  end
end