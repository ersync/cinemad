module MoviesHelper
  def display_crew_information(crew)
    content_tag(:li, class: 'basis-1/3') do
      content_tag(:span, crew.name) +
        display_crew_roles(crew)
    end
  end

  def dynamic_gradient_style(movie)
    base_color = movie.gradient_color
    desktop_alpha_value = "d6"
    mobile_alpha_value = "00"

    { mobile: "linear-gradient(to right, #{base_color} 20%, #{base_color + mobile_alpha_value } 50%);",
      desktop: "linear-gradient(to right, #{base_color} calc(50vw - 170px - 340px), #{base_color + desktop_alpha_value} 50%, #{base_color + desktop_alpha_value} 100%)"
    }
  end

  private

  def display_crew_roles(crew)
    if crew.movie_people.present?
      roles = crew.movie_people.map { |movie_person| movie_person.role.name }
      content_tag(:h4, roles.join(', '), class: 'font-SourceProNormal text-[0.9rem] leading-3')
    else
      content_tag(:h4, 'Role not specified', class: 'font-SourceProNormal text-[0.9rem] leading-3')
    end
  end
end