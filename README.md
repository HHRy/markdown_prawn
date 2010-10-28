Markdown Prawn
==============

Proof of concept for processing Markdown and turning it
into a properly formatted PDF document.

At the moment it doesn't support the entire Markdown spec,
but it will correctly render:

  * Headings
  * Lists (Both kinds)
  * Paragraphs
  * Inline text formatting (if using Prawn > 0.10)

The markdown parser I've built is rather hacky and very
slow; so any improvements that can be made there would
be welcomed. Being the only actual Ruby source code I
could get my hands on, some of it is based on the original
BlueCloth library by Mislav.

Please please test it and let me know what you think and
make any suggestions for improvements. Patches are very
welcome.


Usage:
------

       $ ruby markdown_prawn.rb ./test.md 

Requirements:
-------------

  * Prawn


