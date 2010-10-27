class HeadingFragment < MarkdownFragment
  attr_accessor :level
  
    def render_on(pdf_object, options = {})
      arguments = _default_render_options.merge(options)
      pdf_object.move_down(@level)
      pdf_object.text @content.join(' '), arguments
      pdf_object.move_down(@level * 2)
    end

  private

    def _default_render_options
      options = { :size => 32 / @level, :align => :left, :leading => 2, :weight => :bold }
      if Prawn::VERSION =~ /^0.1/ || Prawn::VERSION =~ /^1/
        options.merge({:inline_format => true})
      end
      options
    end
end