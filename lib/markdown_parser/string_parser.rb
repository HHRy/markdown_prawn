module MarkdownPrawn
  class StringParser < Parser
    # Take a string or an object which responds to to_s and attemps to
    # parse markdown in it.
    def initialize(string_to_convert)
      string_to_convert = string_to_convert.to_s
      @content = detab(string_to_convert.gsub(/\r\n?/, "\n")).split("\n")
      super
    end 
  end
end
