class CastMemberSerializer < BaseSerializer
  def serialize
    {
      id: @object.id,
      name: @object.name,
      image_url: @object.image_url,
      character_names: character_names
    }
  end

  private

  def character_names
    @object.movie_people.map(&:character_name)
  end
end