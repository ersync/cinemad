class BaseSerializer
  def self.serialize(object)
    new(object).serialize
  end

  def self.serialize_collection(objects)
    objects.map { |object| serialize(object) }
  end

  def initialize(object)
    @object = object
  end
end