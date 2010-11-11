Markdown Prawn
==============

Proof of concept for processing Markdown and turning it
into a properly formatted PDF document.

At the moment it doesn't support the entire Markdown spec,
but it will correctly render:

  * Headings
  * Lists (Both kinds)
  * Paragraphs
  * Horizontal Rules
  * Inline text formatting 
  * Link reference lists
  * Inline Links
  * Inline Images (Local and remote)
  * Reference Images

The markdown parser I've built is rather hacky and very
slow; so any improvements that can be made there would
be welcomed. Being the only actual Ruby source code I
could get my hands on, some of it is based on the original
BlueCloth library by Mislav.

Please please test it and let me know what you think and
make any suggestions for improvements. Patches are very
welcome.

If you link a remote image in, it'll use net/http to pull
it down to your OSes tempory folder and then will embed
the image in the PDF.

Supports all the image formants which Prawn supports.

Image Geometry Credits
----------------------

Image geometry for determining the width and height of
JPEG / PNG images is from [This DZone Snippet][1].


What will never be supported
----------------------------

Inline HTML, at least for the forseeable future will not
be supported. Instead, when encountered it will initally
be rendered as a part of a paragaph. Eventually when 
support for code blocks is added, it will be rendered as 
a code block.

The exceptions are the old tags which render bold, italic
or underlined text, as these can be processed by Prawn as
part of its inline formatting functionality.


Why?
----

I use Showoff for presentations and want to be able to 
generate handouts based on my slides. Since Showoff slides
are in Markdown, Prawn Markdown will allow me to render the
slides as sexy documents.

At least, that's the plan!

Also, I can't afford a PrinceXML licence.


Usage:
------

       $ cat ./test.md | ./bin/md2pdf > output.pdf

Requirements:
-------------

  * Prawn, tested against Prawn 0.11.1 (gem install prawn --pre)

[1]: http://snippets.dzone.com/posts/show/805
