class ParagraphFragment < MarkdownFragment

  def render_on(pdf_object, options = {})
    arguments = _default_render_options.merge(options)
    pdf_object.move_down(3)
    pdf_object.text @content.join(' '), arguments
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
