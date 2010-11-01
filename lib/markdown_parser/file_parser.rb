module MarkdownPrawn
  class FileParser < Parser

    # Give this the path to a file and (if it exists), it'll generate 
    # a PDF version of the markdown there.
    #
    def initialize(file_path)
      file_path = File.expand_path(file_path)
      if !File.exist?(file_path)
        raise Errno::ENOENT.new("#{file_path} could not be found") and return
      else
        @content = detab(IO.read(file_path).gsub(/\r\n?/, "\n")).split("\n")
      end
      super
    end

  end
end
