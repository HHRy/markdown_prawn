require 'net/http'
require 'tmpdir'

class ImageFragment < MarkdownFragment
  def render_on(pdf_object)
    if is_remote_uri?
      filename = @content.first.split('/').last
      file_path = "#{Dir.tmpdir}/#{filename}"
      content = Net::HTTP.get(URI.parse(@content.first))
      File.open(file_path, 'w') do |f|
        f.puts content
      end
    else
      file_path = File.expand_path(@content.first)
    end
    pdf_object.image file_path
  end

  private

  def is_remote_uri?
    !/^(http:|https:)/.match(@content.first).nil?
  end

end
