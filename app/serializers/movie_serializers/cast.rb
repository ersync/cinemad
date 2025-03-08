module MovieSerializers
  class Cast < Base
    def serialize
      CastMemberSerializer.serialize_collection(movie.cast_members)
    end
  end
end