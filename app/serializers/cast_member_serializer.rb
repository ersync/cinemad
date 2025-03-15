class CastMemberSerializer < BaseSerializer
  def initialize(object, movie_id)
    super(object)
    @movie_id = movie_id
  end

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
    @object.movie_people.where(movie_id: @movie_id).map(&:character_name)
  end
end