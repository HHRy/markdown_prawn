description = "Markdown Parawn is a library and an executable script which allow you to generate a PDF from any valid Markdown." 
Gem::Specification.new do |spec|
  spec.name = "markdown_prawn"
  spec.version = '0.0.4.pre'
  spec.platform = Gem::Platform::RUBY
  spec.files =  Dir.glob("{bin,lib,test}/**/**/*") +
                      ["Rakefile", "markdown_prawn.gemspec",'markdown_prawn.rb']
  spec.require_path = "lib"
  spec.required_ruby_version = '>= 1.8.7'
  spec.required_rubygems_version = ">= 1.3.6"

  spec.test_files = Dir[ "test/*_test.rb" ]
  spec.has_rdoc = false
  spec.author = "Ryan Stenhouse"
  spec.email = "ryan@ryanstenhouse.eu"
  spec.rubyforge_project = "markdown_prawn"
  spec.add_dependency('prawn', '~>0.10')
  spec.homepage = "http://ryanstenhouse.eu"
  spec.summary = description
  spec.description = description
  spec.executables << 'md2pdf'
end
