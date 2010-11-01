require File.dirname(__FILE__) + '/helper.rb'

class TestParagraphHandling < Test::Unit::TestCase
  
  def setup
    @paragraphs = MarkdownPrawn::FileParser.new(File.expand_path(File.dirname(__FILE__) + '/fixtures/paragraphs.mdown'))
  end

  def test_document_structure_is_correct_for_paragraphs
    @paragraphs.parse
    assert !@paragraphs.document_structure.empty?
    assert_equal 2, @paragraphs.document_structure.nitems
    @paragraphs.document_structure.each do |fragment|
      assert_equal ParagraphFragment, fragment.class
    end
  end

end
