#!/usr/bin/env ruby
require 'rubygems'
require 'prawn'
require File.dirname(__FILE__) + '/lib/markdown_parser.rb'

md_file = File.expand_path(ARGV[0])
output_file = ("#{md_file}.pdf" || ARGV[1])


Prawn::Document.generate(output_file) do |pdf|
  MarkdownParser.new(md_file).each do |element|
    element.render_on(pdf)
  end
end
