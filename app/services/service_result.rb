class ServiceResult
  attr_reader :success, :error

  def initialize(success, error = nil)
    @success = success
    @error = error
  end

  def self.success
    new(true)
  end

  def self.error(message)
    new(false, message)
  end

  def success?
    @success
  end
end