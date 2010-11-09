class ListFragment < MarkdownFragment
  attr_accessor :ordered
  
  def render_on(pdf_object, options = {})
    bullet = '• '
    arguments = _default_render_options.merge(options)
    width = ((pdf_object.bounds.width / 100) * 90)
    data = []

    @content.each_with_index do |item, i|
      # Strip any un-needed white space
      #
      item = item.gsub(/\s\s+/,' ')
      if ordered?
        bullet = "#{i+1}."
      end
      data << [bullet,item]
    end
 
    pdf_object.table data, arguments.merge({:width => width}) do
       cells.borders = []
       column(0).style( { :width => 20  })
    end
    pdf_object.move_down(5) 
  end
  
  def ordered?
    @ordered == true
  end

  private

  def _default_render_options
    options = {}
    if Prawn::VERSION =~ /^0.1/ || Prawn::VERSION =~ /^1/
      options = options.merge({:cell_style =>  { :inline_format => true}})
    end
    options
  end  
  
end
