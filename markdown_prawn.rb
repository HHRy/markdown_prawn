#!/usr/bin/env ruby
require 'rubygems'
require 'prawn'
require File.dirname(__FILE__) + '/lib/markdown_parser.rb'

md_file = File.expand_path(ARGV[0])
output_file = ("#{md_file}.pdf" || ARGV[1])


Prawn::Document.generate(output_file) do |pdf|

  MarkdownParser.new(md_file).each do |line|
    
    if line.is_a?(Prawn::Markdown::Heading)
      pdf.text line.content[0], :size => ( 32 / line.level ), :weight => :bold 
    end

    if line.is_a?(Prawn::Markdown::Paragraph)
      pdf.text line.content.join(' ')
    end

  end

end
