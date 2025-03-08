class CrewSerializer < BaseSerializer
  def serialize
    {
      id: @object.id,
      name: @object.name,
      roles: @object.movie_people.map { |mp| mp.role.name }
    }
  end
end