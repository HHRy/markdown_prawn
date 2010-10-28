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
  * Inline text formatting (if using Prawn > 0.10)

The markdown parser I've built is rather hacky and very
slow; so any improvements that can be made there would
be welcomed. Being the only actual Ruby source code I
could get my hands on, some of it is based on the original
BlueCloth library by Mislav.

Please please test it and let me know what you think and
make any suggestions for improvements. Patches are very
welcome.

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

       $ ruby markdown_prawn.rb ./test.md 

Requirements:
-------------

  * Prawn (0.8 and upwards)


