#!/usr/bin/env ruby
require 'rubygems'
require 'prawn'
require File.dirname(__FILE__) + '/lib/markdown_parser.rb'

md_file = File.expand_path(ARGV[0])
output_file = ("#{md_file}.pdf" || ARGV[1])


MarkdownParser.new(md_file).each do |line|
  puts line.inspect
end
