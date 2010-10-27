class ListFragment < MarkdownFragment
  attr_accessor :ordered
  
  def render_on(pdf_object, options = {})
    bullet = '    •   '
    arguments = _default_render_options.merge(options)
    @content.each_with_index do |item, i|
      if ordered?
        it = i+1
        pdf_object.text "    #{it}.  #{item}"
      else
        pdf_object.text bullet + item
      end
    end
  end
  
  def ordered?
    @ordered == true
  end

  private

  def _default_render_options
    options = { :size => 8, :align => :left, :leading => 2 }
    if Prawn::VERSION =~ /^0.1/ || Prawn::VERSION =~ /^1/
      options.merge({:inline_format => true})
    end
    options
  end  
  
end