# Preface

## The strange history of this book

In January 1999 I was preparing to teach an introductory programming
class in Java. I had taught it three times and I was getting frustrated.
The failure rate in the class was too high and, even for students who
succeeded, the overall level of achievement was too low.

One of the problems I saw was the books. They were too big, with too
much unnecessary detail about Java, and not enough high-level guidance
about how to program. And they all suffered from the trap door effect:
they would start out easy, proceed gradually, and then somewhere around
Chapter 5 the bottom would fall out. The students would get too much new
material, too fast, and I would spend the rest of the semester picking
up the pieces.

Two weeks before the first day of classes, I decided to write my own
book. My goals were:

  - Keep it short. It is better for students to read 10 pages than not
    read 50 pages.

  - Be careful with vocabulary. I tried to minimize jargon and define
    each term at first use.

  - Build gradually. To avoid trap doors, I took the most difficult
    topics and split them into a series of small steps.

  - Focus on programming, not the programming language. I included the
    minimum useful subset of Java and left out the rest.

I needed a title, so on a whim I chose *How to Think Like a
Computer Scientist*.

My first version was rough, but it worked. Students did the reading, and
they understood enough that I could spend class time on the hard topics,
the interesting topics and (most important) letting the students
practice.

I released the book under the GNU Free Documentation License, which
allows users to copy, modify, and distribute the book.

What happened next is the cool part. Jeff Elkner, a high school teacher
in Virginia, adopted my book and translated it into Python. He sent me a
copy of his translation, and I had the unusual experience of learning
Python by reading my own book. As Green Tea Press, I published the first
Python version in 2001.

In 2003 I started teaching at Olin College and I got to teach Python for
the first time. The contrast with Java was striking. Students struggled
less, learned more, worked on more interesting projects, and generally
had a lot more fun.

Since then I’ve continued to develop the book, correcting errors,
improving some of the examples and adding material, especially
exercises.

The result is this book, now with the less grandiose title *Think
Python*. Some of the changes are:

  - I added a section about debugging at the end of each chapter. These
    sections present general techniques for finding and avoiding bugs,
    and warnings about Python pitfalls.

  - I added more exercises, ranging from short tests of understanding to
    a few substantial projects. Most exercises include a link to my
    solution.

  - I added a series of case studies—longer examples with exercises,
    solutions, and discussion.

  - I expanded the discussion of program development plans and basic
    design patterns.

  - I added appendices about debugging and analysis of algorithms.

The second edition of *Think Python* has these new
features:

  - The book and all supporting code have been updated to Python 3.

  - I added a few sections, and more details on the web, to help
    beginners get started running Python in a browser, so you don’t have
    to deal with installing Python until you want to.

  - For Chapter [\[turtle\]](#turtle) I switched from my own turtle
    graphics package, called Swampy, to a more standard Python module,
    `turtle`, which is easier to install and more powerful.

  - I added a new chapter called “The Goodies”, which introduces some
    additional Python features that are not strictly necessary, but
    sometimes handy.

I hope you enjoy working with this book, and that it helps you learn to
program and think like a computer scientist, at least a little bit.

Allen B. Downey  
Olin College  

## Acknowledgments

Many thanks to Jeff Elkner, who translated my Java book into Python,
which got this project started and introduced me to what has turned out
to be my favorite language.

Thanks also to Chris Meyers, who contributed several sections to
*How to Think Like a Computer Scientist*.

Thanks to the Free Software Foundation for developing the GNU Free
Documentation License, which helped make my collaboration with Jeff and
Chris possible, and Creative Commons for the license I am using now.

Thanks to the editors at Lulu who worked on *How to Think Like a
Computer Scientist*.

Thanks to the editors at O’Reilly Media who worked on *Think
Python*.

Thanks to all the students who worked with earlier versions of this book
and all the contributors (listed below) who sent in corrections and
suggestions.

## Contributor List

More than 100 sharp-eyed and thoughtful readers have sent in suggestions
and corrections over the past few years. Their contributions, and
enthusiasm for this project, have been a huge help.

If you have a suggestion or correction, please send email to
`feedback@thinkpython.com`. If I make a change based on your
feedback, I will add you to the contributor list (unless you ask to be
omitted).

If you include at least part of the sentence the error appears in, that
makes it easy for me to search. Page and section numbers are fine, too,
but not quite as easy to work with. Thanks!

  - Lloyd Hugh Allen sent in a correction to Section 8.4.

  - Yvon Boulianne sent in a correction of a semantic error in Chapter
    5.

  - Fred Bremmer submitted a correction in Section 2.1.

  - Jonah Cohen wrote the Perl scripts to convert the LaTeX source for
    this book into beautiful HTML.

  - Michael Conlon sent in a grammar correction in Chapter 2 and an
    improvement in style in Chapter 1, and he initiated discussion on
    the technical aspects of interpreters.

  - Benoit Girard sent in a correction to a humorous mistake in Section
    5.6.

  - Courtney Gleason and Katherine Smith wrote `horsebet.py`,
    which was used as a case study in an earlier version of the book.
    Their program can now be found on the website.

  - Lee Harr submitted more corrections than we have room to list here,
    and indeed he should be listed as one of the principal editors of
    the text.

  - James Kaylin is a student using the text. He has submitted numerous
    corrections.

  - David Kershaw fixed the broken `catTwice` function in
    Section 3.10.

  - Eddie Lam has sent in numerous corrections to Chapters 1, 2, and 3.
    He also fixed the Makefile so that it creates an index the first
    time it is run and helped us set up a versioning scheme.

  - Man-Yong Lee sent in a correction to the example code in Section
    2.4.

  - David Mayo pointed out that the word “unconsciously" in Chapter 1
    needed to be changed to “subconsciously".

  - Chris McAloon sent in several corrections to Sections 3.9 and 3.10.

  - Matthew J. Moelter has been a long-time contributor who sent in
    numerous corrections and suggestions to the book.

  - Simon Dicon Montford reported a missing function definition and
    several typos in Chapter 3. He also found errors in the
    `increment` function in Chapter 13.

  - John Ouzts corrected the definition of “return value" in Chapter 3.

  - Kevin Parks sent in valuable comments and suggestions as to how to
    improve the distribution of the book.

  - David Pool sent in a typo in the glossary of Chapter 1, as well as
    kind words of encouragement.

  - Michael Schmitt sent in a correction to the chapter on files and
    exceptions.

  - Robin Shaw pointed out an error in Section 13.1, where the printTime
    function was used in an example without being defined.

  - Paul Sleigh found an error in Chapter 7 and a bug in Jonah Cohen’s
    Perl script that generates HTML from LaTeX.

  - Craig T. Snydal is testing the text in a course at Drew University.
    He has contributed several valuable suggestions and corrections.

  - Ian Thomas and his students are using the text in a programming
    course. They are the first ones to test the chapters in the latter
    half of the book, and they have made numerous corrections and
    suggestions.

  - Keith Verheyden sent in a correction in Chapter 3.

  - Peter Winstanley let us know about a longstanding error in our Latin
    in Chapter 3.

  - Chris Wrobel made corrections to the code in the chapter on file I/O
    and exceptions.

  - Moshe Zadka has made invaluable contributions to this project. In
    addition to writing the first draft of the chapter on Dictionaries,
    he provided continual guidance in the early stages of the book.

  - Christoph Zwerschke sent several corrections and pedagogic
    suggestions, and explained the difference between
    *gleich* and *selbe*.

  - James Mayer sent us a whole slew of spelling and typographical
    errors, including two in the contributor list.

  - Hayden McAfee caught a potentially confusing inconsistency between
    two examples.

  - Angel Arnal is part of an international team of translators working
    on the Spanish version of the text. He has also found several errors
    in the English version.

  - Tauhidul Hoque and Lex Berezhny created the illustrations in Chapter
    1 and improved many of the other illustrations.

  - Dr. Michele Alzetta caught an error in Chapter 8 and sent some
    interesting pedagogic comments and suggestions about Fibonacci and
    Old Maid.

  - Andy Mitchell caught a typo in Chapter 1 and a broken example in
    Chapter 2.

  - Kalin Harvey suggested a clarification in Chapter 7 and caught some
    typos.

  - Christopher P. Smith caught several typos and helped us update the
    book for Python 2.2.

  - David Hutchins caught a typo in the Foreword.

  - Gregor Lingl is teaching Python at a high school in Vienna, Austria.
    He is working on a German translation of the book, and he caught a
    couple of bad errors in Chapter 5.

  - Julie Peters caught a typo in the Preface.

  - Florin Oprina sent in an improvement in `makeTime`, a
    correction in `printTime`, and a nice typo.

  - D. J. Webre suggested a clarification in Chapter 3.

  - Ken found a fistful of errors in Chapters 8, 9 and 11.

  - Ivo Wever caught a typo in Chapter 5 and suggested a clarification
    in Chapter 3.

  - Curtis Yanko suggested a clarification in Chapter 2.

  - Ben Logan sent in a number of typos and problems with translating
    the book into HTML.

  - Jason Armstrong saw the missing word in Chapter 2.

  - Louis Cordier noticed a spot in Chapter 16 where the code didn’t
    match the text.

  - Brian Cain suggested several clarifications in Chapters 2 and 3.

  - Rob Black sent in a passel of corrections, including some changes
    for Python 2.2.

  - Jean-Philippe Rey at Ecole Centrale Paris sent a number of patches,
    including some updates for Python 2.2 and other thoughtful
    improvements.

  - Jason Mader at George Washington University made a number of useful
    suggestions and corrections.

  - Jan Gundtofte-Bruun reminded us that “a error” is an error.

  - Abel David and Alexis Dinno reminded us that the plural of “matrix”
    is “matrices”, not “matrixes”. This error was in the book for years,
    but two readers with the same initials reported it on the same day.
    Weird.

  - Charles Thayer encouraged us to get rid of the semi-colons we had
    put at the ends of some statements and to clean up our use of
    “argument” and “parameter”.

  - Roger Sperberg pointed out a twisted piece of logic in Chapter 3.

  - Sam Bull pointed out a confusing paragraph in Chapter 2.

  - Andrew Cheung pointed out two instances of “use before def”.

  - C. Corey Capel spotted the missing word in the Third Theorem of
    Debugging and a typo in Chapter 4.

  - Alessandra helped clear up some Turtle confusion.

  - Wim Champagne found a brain-o in a dictionary example.

  - Douglas Wright pointed out a problem with floor division in
    `arc`.

  - Jared Spindor found some jetsam at the end of a sentence.

  - Lin Peiheng sent a number of very helpful suggestions.

  - Ray Hagtvedt sent in two errors and a not-quite-error.

  - Torsten Hübsch pointed out an inconsistency in Swampy.

  - Inga Petuhhov corrected an example in Chapter 14.

  - Arne Babenhauserheide sent several helpful corrections.

  - Mark E. Casida is is good at spotting repeated words.

  - Scott Tyler filled in a that was missing. And then sent in a heap of
    corrections.

  - Gordon Shephard sent in several corrections, all in separate emails.

  - Andrew Turner `spot`ted an error in Chapter 8.

  - Adam Hobart fixed a problem with floor division in `arc`.

  - Daryl Hammond and Sarah Zimmerman pointed out that I served up
    `math.pi` too early. And Zim spotted a typo.

  - George Sass found a bug in a Debugging section.

  - Brian Bingham suggested
    Exercise [\[exrotatepairs\]](#exrotatepairs).

  - Leah Engelbert-Fenton pointed out that I used `tuple` as
    a variable name, contrary to my own advice. And then found a bunch
    of typos and a “use before def”.

  - Joe Funke spotted a typo.

  - Chao-chao Chen found an inconsistency in the Fibonacci example.

  - Jeff Paine knows the difference between space and spam.

  - Lubos Pintes sent in a typo.

  - Gregg Lind and Abigail Heithoff suggested
    Exercise [\[checksum\]](#checksum).

  - Max Hailperin has sent in a number of corrections and suggestions.
    Max is one of the authors of the extraordinary *Concrete
    Abstractions*, which you might want to read when you are done
    with this book.

  - Chotipat Pornavalai found an error in an error message.

  - Stanislaw Antol sent a list of very helpful suggestions.

  - Eric Pashman sent a number of corrections for Chapters 4-11.

  - Miguel Azevedo found some typos.

  - Jianhua Liu sent in a long list of corrections.

  - Nick King found a missing word.

  - Martin Zuther sent a long list of suggestions.

  - Adam Zimmerman found an inconsistency in my instance of an
    “instance” and several other errors.

  - Ratnakar Tiwari suggested a footnote explaining degenerate
    triangles.

  - Anurag Goel suggested another solution for `is_abecedarian` and sent
    some additional corrections. And he knows how to spell Jane Austen.

  - Kelli Kratzer spotted one of the typos.

  - Mark Griffiths pointed out a confusing example in Chapter 3.

  - Roydan Ongie found an error in my Newton’s method.

  - Patryk Wolowiec helped me with a problem in the HTML version.

  - Mark Chonofsky told me about a new keyword in Python 3.

  - Russell Coleman helped me with my geometry.

  - Nam Nguyen found a typo and pointed out that I used the Decorator
    pattern but didn’t mention it by name.

  - Stéphane Morin sent in several corrections and suggestions.

  - Paul Stoop corrected a typo in `uses_only`.

  - Eric Bronner pointed out a confusion in the discussion of the order
    of operations.

  - Alexandros Gezerlis set a new standard for the number and quality of
    suggestions he submitted. We are deeply grateful!

  - Gray Thomas knows his right from his left.

  - Giovanni Escobar Sosa sent a long list of corrections and
    suggestions.

  - Daniel Neilson corrected an error about the order of operations.

  - Will McGinnis pointed out that `polyline` was defined
    differently in two places.

  - Frank Hecker pointed out an exercise that was under-specified, and
    some broken links.

  - Animesh B helped me clean up a confusing example.

  - Martin Caspersen found two round-off errors.

  - Gregor Ulm sent several corrections and suggestions.

  - Dimitrios Tsirigkas suggested I clarify an exercise.

  - Carlos Tafur sent a page of corrections and suggestions.

  - Martin Nordsletten found a bug in an exercise solution.

  - Sven Hoexter pointed out that a variable named `input`
    shadows a build-in function.

  - Stephen Gregory pointed out the problem with `cmp` in
    Python 3.

  - Ishwar Bhat corrected my statement of Fermat’s last theorem.

  - Andrea Zanella translated the book into Italian, and sent a number
    of corrections along the way.

  - Many, many thanks to Melissa Lewis and Luciano Ramalho for excellent
    comments and suggestions on the second edition.

  - Thanks to Harry Percival from PythonAnywhere for his help getting
    people started running Python in a browser.

  - Xavier Van Aubel made several useful corrections in the second
    edition.

  - William Murray corrected my definition of floor division.

  - Per Starbäck brought me up to date on universal
    newlines in Python 3.
    
    In addition, people who spotted typos or made corrections include
    Czeslaw Czapla, Dale Wilson, Richard Fursa, Brian McGhie, Lokesh
    Kumar Makani, Matthew Shultz, Viet Le, Victor Simeone, Lars O.D.
    Christensen, Swarup Sahoo, Alix Etienne, Kuang He, Wei Huang, Karen
    Barber, and Eric Ransom.

