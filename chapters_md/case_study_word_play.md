# Case study: word play

This chapter presents the second case study, which involves solving word
puzzles by searching for words that have certain properties. For
example, we’ll find the longest palindromes in English and search for
words whose letters appear in alphabetical order. And I will present
another program development plan: reduction to a previously solved
problem.

## Reading word lists

For the exercises in this chapter we need a list of English words. There
are lots of word lists available on the Web, but the one most suitable
for our purpose is one of the word lists collected and contributed to
the public domain by Grady Ward as part of the Moby lexicon project (see
https://wikipedia.org/wiki/Moby_Project). It is a list of 113,809
official crosswords; that is, words that are considered valid in
crossword puzzles and other word games. In the Moby collection, the
filename is `113809of.fic`; you can download a copy from
https://www.gutenberg.org/files/3201/files/CROSSWD.TXT. For this
chapter, the file is renamed as `words.txt` and DOS style
line endings have been converted to UNIX style (use dos2unix command if
available or use: `sed 's/\r$//'`).

This file is in plain text, so you can open it with a text editor, but
you can also read it from Ruby. The `File` class method
`open` takes the name of the file as a parameter and returns
a **File object** you can use to read the file.

```ruby
>> fin = File.open('words.txt')
=> #<File:words.txt>
```

`fin` is a common name for a file object used for input. The
file object provides several methods for reading, including
`readline`, which reads characters from the file until it
gets to a newline and returns the result as a string:

```ruby
>> fin.readline
=> "aa\n"
```

The first word in this particular list is “aa”, which is a kind of lava.
The sequence `\n` represents the newline character that separates this
word from the next.

The file object keeps track of where it is in the file, so if you call
`readline` again, you get the next word:

```ruby
>> fin.readline
=> "aah\n"
```

The next word is “aah”, which is a perfectly legitimate word, so stop
looking at me like that. Or, if it’s the newline character that’s
bothering you, we can get rid of it with the string method
`strip`:

```ruby
>> line = fin.readline
=> "aahed\n"
>> word = line.strip
=> "aahed"
```

You can also use a file object as part of a `for` loop. This
program reads `words.txt` and prints each word, one per line:

```ruby
fin = File.open('words.txt')
for line in fin
  word = line.strip
  puts word
end
```

## Exercises

There are solutions to these exercises in the next section. You should
at least attempt each one before you read the solutions.

**Exercise 1**  
Write a program that reads `words.txt` and prints only the
words with more than 20 characters (not counting whitespace).

**Exercise 2**  
In 1939 Ernest Vincent Wright published a 50,000 word novel called
*Gadsby* that does not contain the letter “e”. Since “e” is
the most common letter in English, that’s not easy to do.

In fact, it is difficult to construct a solitary thought without using
that most common symbol. It is slow going at first, but with caution and
hours of training you can gradually gain facility.

All right, I’ll stop now.

Write a method called `no_e?` that returns `true` if the
given word doesn’t have the letter “e” in it.

Modify your program from the previous section to print only the words
that have no “e” and compute the percentage of the words in the list
that have no “e”.

**Exercise 3**  
Write a method named `avoids?` that takes a word and a string
of forbidden letters, and that returns `true` if the word
doesn’t use any of the forbidden letters.

Modify your program to prompt the user to enter a string of forbidden
letters and then print the number of words that don’t contain any of
them. Can you find a combination of 5 forbidden letters that excludes
the smallest number of words?

**Exercise 4**  
Write a method named `uses_only?` that takes a word and a string of
letters, and that returns `true` if the word contains only
letters in the list. Can you make a sentence using only the letters
`acefhlo`? Other than “Hoe alfalfa?”

**Exercise 5**  
Write a method named `uses_all?` that takes a word and a string of
required letters, and that returns `true` if the word uses
all the required letters at least once. How many words are there that
use all the vowels `aeiou`? How about `aeiouy`?

**Exercise 6**  
Write a method called `abecedarian?` that returns `true` if
the letters in a word appear in alphabetical order (double letters are
ok). How many abecedarian words are there?

## Search

All of the exercises in the previous section have something in common;
they can be solved with the search pattern we saw in
Section [Searching](./strings.md#searching). The simplest example is:

```ruby
def no_e?(word)
  for letter in word.chars
    return false if letter == 'e'
  end
  return true
end
```

The `for` loop traverses the characters in `word`.
If we find the letter “e”, we can immediately return `false`;
otherwise we have to go to the next letter. If we exit the loop
normally, that means we didn’t find an “e”, so we return
`true`.

You could write this method more concisely using the
`include?` method, but I started with this version because it
demonstrates the logic of the search pattern.

`avoids?` is a more general version of `no_e?` but it has the
same structure:

```ruby
def avoids?(word, forbidden)
  for letter in word.chars
    return false if forbidden.include?(letter)
  end
  return true
end
```

We can return `false` as soon as we find a forbidden letter;
if we get to the end of the loop, we return `true`.

`uses_only?` is similar except that the sense of the condition is
reversed:

```ruby
def uses_only?(word, available)
  for letter in word.chars
    return false if !available.include?(letter)
  end
  return true
end
```

Instead of a list of forbidden letters, we have a list of available
letters. If we find a letter in `word` that is not in
`available`, we can return `false`.

`uses_all?` is similar except that we reverse the role of the word and
the string of letters:

```ruby
def uses_all?(word, required)
  for letter in required.chars
    return false if !word.include?(letter)
  end
  return true
end
```

Instead of traversing the letters in `word`, the loop
traverses the required letters. If any of the required letters do not
appear in the word, we can return `false`.

If you were really thinking like a computer scientist, you would have
recognized that `uses_all?` was an instance of a previously solved
problem, and you would have written:

```ruby
def uses_all?(word, required)
  return uses_only?(required, word)
end
```

This is an example of a program development plan called
**reduction to a previously solved problem**, which means
that you recognize the problem you are working on as an instance of a
solved problem and apply an existing solution.

## Looping with indices

I wrote the methods in the previous section with `for` loops
because I only needed the characters in the strings; I didn’t have to do
anything with the indices.

For `abecedarian?` we have to compare adjacent letters, which is a
little tricky with a `for` loop:

```ruby
def abecedarian?(word)
  previous = word[0]
  for c in word.chars
    return false if c < previous
    previous = c
  end
  return true
end
```

An alternative is to use recursion:

```ruby
def abecedarian?(word)
  return true if word.length <= 1
  return false if word[0] > word[1]
  return abecedarian?(word[1..-1])
end
```

Another option is to use a `while` loop:

```ruby
def abecedarian?(word)
  i = 0
  while i < word.length-1
    return false if word[i+1] < word[i]
    i = i+1
  end
  return true
end
```

The loop starts at `i=0` and ends when
`i=word.length-1`. Each time through the loop, it compares
the `i`th character (which you can think of as the current character)
to the `i+1`th character (which you can think of as the next).

If the next character is less than (alphabetically before) the current
one, then we have discovered a break in the abecedarian trend, and we
return `false`.

If we get to the end of the loop without finding a fault, then the word
passes the test. To convince yourself that the loop ends correctly,
consider an example like `'flossy'`. The length of the word is 6, so the
last time the loop runs is when `i` is 4, which is the index
of the second-to-last character. On the last iteration, it compares the
second-to-last character to the last, which is what we want.

Here is a version of `palindrome?` (see Exercises from
[Fruitful methods](./fruitful_methods.md#exercises) chapter) that uses
two indices; one starts at the beginning and goes up; the other starts
at the end and goes down.

```ruby
def palindrome?(word)
  i = 0
  j = word.length-1

  while i < j
    return false if word[i] != word[j]
    i = i+1
    j = j-1
  end

  return true
end
```

Or we could reduce to a previously solved problem and write:

```ruby
def palindrome?(word)
  return reverse?(word, word)
end
```

Using `reverse?` from Section [Debugging](./strings.md#) of Strings
chapter.

## Debugging

Testing programs is hard. The methods in this chapter are relatively
easy to test because you can check the results by hand. Even so, it is
somewhere between difficult and impossible to choose a set of words that
test for all possible errors.

Taking `no_e?` as an example, there are two obvious cases to check:
words that have an ‘e’ should return `false`, and words that
don’t should return `true`. You should have no trouble coming
up with one of each.

Within each case, there are some less obvious subcases. Among the words
that have an “e”, you should test words with an “e” at the beginning,
the end, and somewhere in the middle. You should test long words, short
words, and very short words, like the empty string. The empty string is
an example of a **special case**, which is one of the
non-obvious cases where errors often lurk.

In addition to the test cases you generate, you can also test your
program with a word list like `words.txt`. By scanning the
output, you might be able to catch errors, but be careful: you might
catch one kind of error (words that should not be included, but are) and
not another (words that should be included, but aren’t).

In general, testing can help you find bugs, but it is not easy to
generate a good set of test cases, and even if you do, you can’t be sure
your program is correct. According to a legendary computer scientist:

> Program testing can be used to show the presence of bugs, but never to
> show their absence!
> 
> — Edsger W. Dijkstra

## Glossary

  - **file object**:  
    A value that represents an open file.

  - **reduction to a previously solved problem**:  
    A way of solving a problem by expressing it as an instance of a
    previously solved problem.

  - **special case**:  
    A test case that is atypical or non-obvious (and less likely to be
    handled correctly).

## Exercises

**Exercise 7**  
This question is based on a Puzzler that was broadcast on the radio
program *Car Talk*
(https://www.cartalk.com/puzzler/browse):

> Give me a word with three consecutive double letters. I’ll give you a
> couple of words that almost qualify, but don’t. For example, the word
> committee, c-o-m-m-i-t-t-e-e. It would be great except for the ‘i’
> that sneaks in there. Or Mississippi: M-i-s-s-i-s-s-i-p-p-i. If you
> could take out those i’s it would work. But there is a word that has
> three consecutive pairs of letters and to the best of my knowledge
> this may be the only word. Of course there are probably 500 more but I
> can only think of one. What is the word?

Write a program to find it.

**Exercise 8**  
Here’s another *Car Talk* Puzzler
(https://www.cartalk.com/puzzler/browse):

> “I was driving on the highway the other day and I happened to notice
> my odometer. Like most odometers, it shows six digits, in whole miles
> only. So, if my car had 300,000 miles, for example, I’d see
> 3-0-0-0-0-0.
> 
> “Now, what I saw that day was very interesting. I noticed that the
> last 4 digits were palindromic; that is, they read the same forward as
> backward. For example, 5-4-4-5 is a palindrome, so my odometer could
> have read 3-1-5-4-4-5.
> 
> “One mile later, the last 5 numbers were palindromic. For example, it
> could have read 3-6-5-4-5-6. One mile after that, the middle 4 out of
> 6 numbers were palindromic. And you ready for this? One mile later,
> all 6 were palindromic!
> 
> “The question is, what was on the odometer when I first looked?”

Write a Ruby program that tests all the six-digit numbers and prints any
numbers that satisfy these requirements.

**Exercise 9**  
Here’s another *Car Talk* Puzzler you can solve with a
search (https://www.cartalk.com/puzzler/browse):

> “Recently I had a visit with my mom and we realized that the two
> digits that make up my age when reversed resulted in her age. For
> example, if she’s 73, I’m 37. We wondered how often this has happened
> over the years but we got sidetracked with other topics and we never
> came up with an answer.
> 
> “When I got home I figured out that the digits of our ages have been
> reversible six times so far. I also figured out that if we’re lucky it
> would happen again in a few years, and if we’re really lucky it would
> happen one more time after that. In other words, it would have
> happened 8 times over all. So the question is, how old am I now?”

Write a Ruby program that searches for solutions to this Puzzler. Hint:
you might find the string method `rjust` useful.

