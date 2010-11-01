require File.dirname(__FILE__) + '/helper.rb'

class TestListsHandling < Test::Unit::TestCase

  def setup
    @unordered = MarkdownPrawn::FileParser.new(File.expand_path(File.dirname(__FILE__) + '/fixtures/unordered_lists.mdown'))
    @ordered = MarkdownPrawn::FileParser.new(File.expand_path(File.dirname(__FILE__) + '/fixtures/ordered_lists.mdown'))
  end

  def test_document_structure_is_correct_for_unordered_lists
    @unordered.parse
    assert !@unordered.document_structure.empty?
    assert_equal ListFragment, @unordered.document_structure[0].class
    assert_equal false, @unordered.document_structure[0].ordered?
  end

  def test_document_structure_is_correct_for_ordered_lists
    @ordered.parse
    assert !@ordered.document_structure.empty?
    assert_equal ListFragment, @ordered.document_structure[0].class
    assert_equal true, @ordered.document_structure[0].ordered?
  end

end
