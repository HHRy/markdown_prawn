require File.dirname(__FILE__) + '/markdown_fragments/markdown_fragment.rb'
require File.dirname(__FILE__) + '/markdown_fragments/paragraph_fragment.rb'
require File.dirname(__FILE__) + '/markdown_fragments/heading_fragment.rb'
require File.dirname(__FILE__) + '/markdown_fragments/list_fragment.rb'

# Horribly bodgy and wrong markdown parser which should just about do
# for a proof of concept. Some of the code comes from mislav's original
# BlueCloth since I cant find the source of a newer versoin.
#
class MarkdownParser

  def initialize(path_to_file)
    # Convert tabs to spaces, make every line use \n 
    #
    @content = detab(IO.read(path_to_file).gsub(/\r\n?/, "\n")).split("\n")
  end

  def each(&block)
    document_structure = []
    paragraph = ParagraphFragment.new
    list = ListFragment.new
    in_list = false
    @content.each_with_index do |line, index|
      line = process_inline_formatting(line)
  
      # Assume everything is part of a paragraph by default and
      # add its content to the current in-scope paragraph object.
      #
      paragraph.content << line
      if line == ""
        unless paragraph.content.empty?
          document_structure << paragraph
          paragraph = ParagraphFragment.new
        end
      end
      
      # Deal with inline headings
      #
      unless /^(#+)(\s?)\S/.match(line).nil?
        paragraph.content = paragraph.content.delete_if { |i| i == line }
        hashes = $1.dup
        heading = HeadingFragment.new([line.gsub(hashes,'')])
        heading.level = hashes.length
        document_structure << heading
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

      # Try to deal with lists.
      #
      if in_list
        # We're in a list just now.
        #

        # Remove the content from the paragraph where it will have
        # automatically been appended
        #
        paragraph.content = paragraph.content.delete_if { |i| i == line }

        # Check to see if we've got a new list item.
        #
        if (!/^\s+\*\s/.match(line).nil? || !/^\s+\d+\.\s/.match(line).nil?)

          # Find out if this new list item is for a different type of list 
          # and deal with that before adding the new list item.
          #
          if list.ordered? && !/^\s+\*\s/.match(line).nil?
            document_structure << list
            list = ListFragment.new
         elsif !list.ordered? && !/^\s+\d+\.\s/.match(line).nil?
            document_structure << list
            list = ListFragment.new
            list.ordered = true
         end

          # Remove the list style and add the new list item.
          #
          list.content << line.sub(/^\s+\*\s/,'').sub(/^\s+\d+\.\s/,'')

        else
          # If this line isn't a new list item, then it's a continuation for the current
          # list item.
          #
          list.content[-1] += line
        end

        # If the current line is empty, then we're done with the list.
        #
        if line == '' 
          document_structure << list
          list = ListFragment.new
          in_list = false
        end
      else
        # Not currently in a list, but we've detected a list item
        #
        if (!/^\s+\*\s/.match(line).nil? || !/^\s+\d+\.\s/.match(line).nil?)
          ordered = false
          ordered = true if !/^\s+\d+\.\s/.match(line).nil?
          list = ListFragment.new
          list.ordered = ordered
          list.content << line.sub(/^\s+\*\s/,'').sub(/^\s+\d+\.\s/,'')
          paragraph.content = paragraph.content.delete_if { |i| i == line }
          in_list = true
        end
      end


    end
    document_structure << paragraph unless paragraph.content == ''
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
