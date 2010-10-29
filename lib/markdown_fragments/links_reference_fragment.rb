class LinksReferenceFragment < MarkdownFragment

  def render_on(pdf_object)

    pdf_object.move_down(10)
    pdf_object.horizontal_rule
    pdf_object.stroke
    pdf_object.move_down(4)
    pdf_object.text "Hyperlink References:"
    pdf_object.move_down(4)
    pdf_object.table @content do
      cells.borders = []
    end
    pdf_object.move_down(4)
  end

end
