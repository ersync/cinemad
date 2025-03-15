class BaseSerializer
  def self.serialize(object, *args)
    new(object, *args).serialize
  end
  
  def self.serialize_collection(objects, *args)
    objects.map { |object| serialize(object, *args) }
  end
  
  def initialize(object, *args)
    @object = object
  end
end