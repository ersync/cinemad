module MovieSerializers
  class Base < BaseSerializer
    private

    def movie
      @object
    end
  end
end