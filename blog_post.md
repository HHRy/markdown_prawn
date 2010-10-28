Ruby / Rails the 'Enterprise' and how software works in the 'real world'
========================================================================

The 'real world' is an emotive term when it comes to software development. It parcels off your
skills and experience to one side and holds it against and in comparison to a mythical 
archetype of 'reality' which seems to have little, if any, relevance to how, where and why you
work. In this context, the 'real world' is subjective and is defined by the person who is
making the comparison.

The 'enterprise' is another one of these terms which conjures up different images for different
people and is the subject of many debates across the internet, especially in the Ruby world.

In this post, I draw upon my own work and personal experience to discuss both these topics and
try to see where Ruby and Rails sit in the 'real world' as it pertains to me, and within the 
'enterprise'.

###What is my 'real world'?

My 'real world' when it comes to software development is grounded entirely in my day job, as
a senior developer and technical lead for a relatively small [software company based in Fife][2] in
Scotland. I'm responsible for the design and implementation of technologies and infrastructure 
relating to the payment card industry, organisational purchase-to-pay systems and financial 
management, all of which have the following basic requirements:

  *  **Reliability**. Our customers have to be able to rely on our products, systems and
     applications. This means that they always have to be available, always have to work
     first time and always behave as expected, regardless of load.
  *  **Quality**. To deliver the reliability our customers need, our work has to be of the
     highest quality. By following effective test-driven development strategies, encouraging
     pair programming and agile working we ensure quality.
  *  **Security**. Mentioned last, but probably the most important part; our products, systems
     and applications need to meet tough industry standards such as the Payment Card 
     Industry's Data Security Standard.

I can't say too much about our customers here, but what I can say is that they are public sector
bodies of all sizes in local and national government, large multinational corporations and colleges
/ universities.

By [many definitions][1] the work I carry out can be classed as 'enterprise' software development, 
'enterprise' systems integration and 'enterprise' systems architecture. 

The approach I  take in all aspects of my work is, by necessity, a [pragmatic one][3], where all 
decisions must be weighed up against business needs, costs (including cost of change), time, technical 
debt, benefits (to process / product / working), compatibility, upgrade paths, conflicts, and a host of 
other little details. In January 2011 I will have been working in this capacity for four years.

To summarise, my 'real world' is one where all technology decisions have to be weighed on merit, benefits
and costs, with a long view to compatibility with existing systems and upgrade paths for others. Where
business need has to be strongly weighed and where benefits have to outstrip risks and costs before something
can be implemented.

###Where does Ruby sit?

One of the many things that attracted me to Ruby and Rails in the first place was that the community
seemed to understand that working pragmatically was a good thing and that by making quality part of
your development process through rigorous adherence to test-driven development and by evangelising
agile methodologies you can really drive a business and your products forward.

The Ruby community is famed for being inclusive, helpful and friendly to new and old members alike and
is a wealth of information and support (especially if you can understand Japanese - a subject of another
post, I think). The unofficial motto of the Ruby community is MINASWAN, Matz is nice and so we are nice.

This is something I have found to be true in many  great Ruby projects such as [Prawn][4], [Gruff][5] 
and [Sinatra][6].

Ruby undergoes rapid development with a team of contributors from all over the world contributing currently
to two 'official' versions, the 1.8.X series (MRI) and the 1.9.X series (YARV). Both have stable and development 
versions available and security updates are regularly applied. 

Ruby as a language is very mature and has been around since 1994. Its popularity has lead to many third party
implementations of the language, such as JRuby (Sponsored by Sun), Rubinius, IronRuby (Sponsored by Microsoft) 
and MacRuby. Due to the Rubinius project there is a large suite of tests to define the functionality of a functioning
Ruby interpreter which are used by all of these projects, including the official ones, for the testing of releases.

It's my opinion that because of this large level of support, the multiple options available for integrating a Ruby 
interpreter into your application environment and the widespread distribution of installed instances, supporting
documentation and other resources available that Ruby is indeed 'enterprise' quality software and is suitable for 
use in building 'enterprise' applications. Indeed, Ruby is at the heart of the programming work I do. 

The problem is that many 'enterprise' operating systems are badly lagging behind in their support for Ruby. Red
Hat Enterprise Linux currently ships with an interpreter which purports to be version 1.8.5, but isn't exactly
because of their back-porting of patches. The soon to be released version 6 of RHEL ups this to 1.8.6, still two
years behind the current 'stable' version.

You are, of course, free to compile and install your own Ruby version on your production machine, and indeed this
will be required if you want to deploy to a Windows Server, since no native support is provided. Installing custom
packages in this way, however, does go against the spirit of an 'enterprise' server distribution and should be weighed
carefully against business needs. 

###What about Rails?

The current state of Ruby, particularly with regards to its popularity and inclusion in many
operating systems has a lot to do with the popularity and unabashedly aggressive publicity of 
[Rails][7] and the people behind it. 

Rails, for those who don't know, is a 'web application framework' which provides a structured 
environment for building software which is accessed via the internet. You can find out more
about it on [its website][7].

Rails development happens at a rapid pace, as one would probably expect form a young, but established
tool in this competitive world. This has, however brought several drawbacks to settling on Rails for 
developing web-facing applications, especially in my 'real world'.

One main drawback is the rapid release cycle of major versions which often break backwards compatibility.
The most recent release of Rails 3 includes a new technology [Bundler][8] which will partially solve 
this problem for future releases; but is not sufficiently backwards compatible to be of use to many previous
versions of Rails.

The following problems are presented if you're in the not unrealistic situation of having a machine on which 
you deploy Rails 2.1 and 2.3 applications to, your only box configured for running Ruby applications; but 
wish to develop and deploy a new application using the new features of Rails 3. 

  1. Enterprise Linux distributions support ancient versions of Ruby. Ruby 1.8.7 is required to
     use Rails 3.
  2. RubyGems, a dependancy of Rails also requires a newer version of Ruby than the standard currently
     available in Enterprise Linux distributions.
  3. Due to how RubyGems works (and the problem Bundler partially solves), installing Rails 3 beside 
     Rails 2.1 and 2.3 (issues with 2.3 can be solved also with Bundler if a new enough version of 2.3
     is installed) will cause your existing applications to break in interesting ways.

These pitfalls are well documented elsewhere so I won't be going to be going into the whys, whatfors or
the workarounds here at this time. The cost / benefit of upgrading potentially complicated applications
to use the latest compatible version of the Framework should be carefully analysed.

Rails' community is on the whole its biggest weakness. While there is a large overlap between it and
the greater Ruby community, Rails specific support avenues, particularly forums and IRC, attract a 
less mature and experienced collection of users who do not have the same breadth of knowledge required
for informed debate and discussion. This makes it hard to discuss topics and issues in order to make 
informed and pragmatic business decisions.

Software updates to deprecated versions of Rails are few and far between. At my employer we have provided
patches to older versions of Rails, hoping to have them included in an eventual update for people who may
be in a similar situation only to have fully tested patches refused. None of these were security issues, 
true, but did fix bugs.

Rails has lost the pragmatism that it started with and has pushed on (boldly and arguably rightly) towards
new technologies and greater impact and 'shininess' at the expense of older adopters of Rails who won
the 'battle for the enterprise' and convinced the employers to start developing applications based on a 
Ruby and Rails stack. 

If you are an adherent to the sprit of 'enterprise' server distributions and are unable to update your
existing applications to use a newer version of Rails or are unable to update the version of Ruby to 
one other than the version shipping with your distribution, then Rails as it is just now is not available
for you and is going to continue to move further away from the 'enterprise' and where it could do the
most good.

Rails simply won't sit still long enough or think hard enough about the consequences of its decisions for
users who aren't startups funded by bottomless pits of venture capital, or one-service shops who only do
one thing. True 'enterprise' users of Rails are left behind unsupported and told "lol upgrade" or "lol
buy more hardware". 

In my opinion this is simply not good enough and is more likely than not to be damaging to Rails in the long 
run. It needs the support and acceptance of the 'enterprise' to be a proper world-class contender, and its 
mismanagement / misdirection is crossing bridges too quickly and its lack of a mature community is burning 
those bridges right behind it. 

###To close (or the TL;DR version)

This is an opinion piece where I've tried to clearly put down my thoughts on the current state of Ruby and
Rails in the 'enterprise' and in the 'real world' as they pertain to my day to day working life providing
software and other technology to large organisations throughout the world.

I love Ruby and continue to evangelise its use wherever I can. I used to feel the same way about Rails, but
after some very shaky releases and the reasons outlined above I can't justify it as a go-to tool at the 
moment. Rails has lost its way and become too bogged down in personalities, cliques and politics to the point
where the problems it solves were are overshadowed by an unfriendly, agressive, accept-no-questions community.

Enterprise Linux software is also part of the problem, where Ruby is not treated as a first class package.
Outdated software is often a problem of long release cycles; but with pressure from the community, these linux
distributions could be pressured into making more effort with Ruby and giving it the treatment it deserves.

Remember that pragmatism is never a bad thing when it comes to programming in general, and please, Rails find
your pragmatic outlook again and concentrate on your bricks-and-mortar and building an unassailable foundation
on solid dependable rock before you start building castles in the sky.

[1]: http://en.wikipedia.org/wiki/Enterprise_software
[2]: http://pccl.co.uk
[3]: http://j.mp/9GIqKk
[4]: http://prawn.majesticseacreature.com/
[5]: http://nubyonrails.com/pages/gruff
[6]: http://www.sinatrarb.com/
[7]: http://rubyonrails.org/
[8]: http://gembundler.com/
