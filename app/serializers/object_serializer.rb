class ObjectSerializer
  attr_reader :object

  def initialize(object, root: nil)
    @object = object
    @root = root
  end

  def response(status: 200)
    {
      json: as_json,
      status: status
    }
  end

  def as_json(options = nil)
    {
      root => serialize
    }
  end

  # Implemented by subclasses
  def serialize
    {}
  end

  private

    def root
      @root || object.class.name.demodulize.underscore
    end

end