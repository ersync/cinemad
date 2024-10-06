module ApplicationHelper
  require 'color' # make sure 'color' gem is in your Gemfile

  def darken_color(hex_color, amount = 0.1)
    color = Color::RGB.by_hex(hex_color)
    darkened = color.darken_by(amount * 100)
    "#" + darkened.hex
  end
end