# Don't rely on this for any serious MarkDown parsing, it's
# based on the very dead original BlueCloth parser by mislav
# and is only here so I don't need to write a markdown parser
# from scratch entirely.
#

require File.dirname(__FILE__) + '/markdown_fragments/markdown_fragment.rb'
require File.dirname(__FILE__) + '/markdown_fragments/paragraph_fragment.rb'
require File.dirname(__FILE__) + '/markdown_fragments/heading_fragment.rb'


class MarkdownParser

  def initialize(path_to_file)
    # Convert tabs to spaces, make every line use \n 
    #
    @content = detab(IO.read(path_to_file).gsub(/\r\n?/, "\n")).split("\n")
  end

  def each(&block)
    document_structure = []
    paragraph = ParagraphFragment.new

    @content.each_with_index do |line, index|
      line = process_inline_formatting(line)
      paragraph.content << line
      if line == ""
        unless paragraph.content.empty?
          document_structure << paragraph
          paragraph = ParagraphFragment.new
        end
      end

      # Deal with Level 1 Headings
      #
      if !/^(=)+$/.match(line).nil?
        paragraph.content = paragraph.content.delete_if do |item|
          item == line || item == @content[index - 1]
        end
        heading = HeadingFragment.new([@content[index - 1]])
        heading.level = 1
        document_structure << heading
      end

      # Deal with Level 2 Headings
      #
      if !/^(-)+$/.match(line).nil?
        paragraph.content = paragraph.content.delete_if do |item|
          item == line || item == @content[index - 1]
        end
        heading = HeadingFragment.new([@content[index - 1]])
        heading.level = 2
        document_structure << heading
      end

    end
    document_structure.each { |l| yield l }
  end

  private

  def detab(string, tabwidth = 2)
    string.split("\n").collect { |line|
      line.gsub(/(.*?)\t/) do
        $1 + ' ' * (tabwidth - $1.length % tabwidth)
      end
    }.join("\n")
  end

  # Only do Inline formatting for versions of Prawn which support it.
  #
  def process_inline_formatting(str)
    breg = [ %r{ \b(\_\_) (\S|\S.*?\S) \1\b }x, %r{ (\*\*) (\S|\S.*?\S) \1 }x ]
    ireg = [ %r{ (\*) (\S|\S.*?\S) \1 }x, %r{ \b(_) (\S|\S.*?\S) \1\b }x ]
    if Prawn::VERSION =~ /^0.1/ || Prawn::VERSION =~ /^1/
      str.gsub(breg[0], %{<b>\\2</b>} ).gsub(breg[1], %{<b>\\2</b>} ).gsub(ireg[0], %{<i>\\2</i>} ).gsub(ireg[1], %{<i>\\2</i>} )
    else
      str.gsub(breg[0], %{\\2} ).gsub(breg[1], %{\\2} ).gsub(ireg[0], %{\\2} ).gsub(ireg[1], %{\\2} )
    end
  end

end
