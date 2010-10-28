class HorizontalRuleFragment < MarkdownFragment

  def render_on(pdf_object, options = {})
    pdf_object.move_down(3)
    old_width = pdf_object.line_width
    pdf_object.line_width = 3
    pdf_object.horizontal_rule
    pdf_object.stroke
    pdf_object.line_width = old_width
    pdf_object.move_down(3)
  end

private

  def _default_render_options
    options = { :size => 12, :align => :left, :leading => 2 }
    if Prawn::VERSION =~ /^0.1/ || Prawn::VERSION =~ /^1/
      options = options.merge({:inline_format => true})
    else
      options = options.merge({:inline_format => false})
    end
    options
  end

end
