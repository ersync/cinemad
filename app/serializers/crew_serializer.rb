class CrewSerializer < BaseSerializer
  def initialize(object, movie_id)
    super(object)
    @movie_id = movie_id
  end
  
  def serialize
    {
      id: @object.id,
      name: @object.name,
      roles: @object.movie_people
              .where(movie_id: @movie_id)
              .includes(:role)
              .map { |mp| mp.role.name }
    }
  end
end