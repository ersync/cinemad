module MoviesHelper
  def display_crew_information(crew)
    content_tag(:li, class: 'basis-1/2') do
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

  def render_list(items, partial:, item_name:, item_class: '', list_class: '')
    content_tag :div, class: list_class do
      items.map { |item| render partial, item_name => item, class: item_class }.join.html_safe
    end
  end

  def filter_box(title:, &block)
    content_tag :div, class: 'filter-box' do
      concat(content_tag(:div, class: 'filter-header') do
        concat content_tag(:div, title, class: 'filter-title')
        concat raw <<-HTML
        <svg class="chevron-icon block w-4 h-4 transition-all duration-200">
          <use xlink:href="#chevron-right-thick"></use>
        </svg>
        HTML
      end)
      concat(content_tag(:div, capture(&block), class: 'filter-content overflow-hidden opacity-0 invisible max-h-0'))
    end
  end

  def checkbox_group(form, name, options, all_option: true)
    content_tag(:div) do
      if all_option
        concat form.check_box("all_#{name}", class: "peer form-checkbox mb-1", checked: true, include_hidden: true)
        concat form.label("all_#{name}", "All #{name.to_s.titleize}?", class: "inline-block cursor-pointer ml-1.5 mb-1")
      end

      concat(content_tag(:div, class: all_option ? "block peer-checked:hidden" : "") do
        options.each do |option|
          concat(content_tag(:label, class: "cursor-pointer flex items-center mb-1") do
            concat form.check_box(option, class: "form-checkbox", include_hidden: true)
            concat content_tag(:span, option.to_s.titleize, class: "ml-1.5")
          end)
        end
      end)
    end
  end

  private

  def display_crew_roles(crew)
    if crew.movie_people.present?
      roles = crew.movie_people.map { |movie_person| movie_person.role.name }
      content_tag(:h4, roles.join(', '), class: 'font-SourceProNormal text-[0.9rem] leading-3 opacity-90')
    else
      content_tag(:h4, 'Role not specified', class: 'font-SourceProNormal text-[0.9rem] leading-3')
    end
  end
end