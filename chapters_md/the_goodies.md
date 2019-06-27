# The Goodies

One of my goals for this book has been to teach you as little Python as
possible. When there were two ways to do something, I picked one and
avoided mentioning the other. Or sometimes I put the second one into an
exercise.

Now I want to go back for some of the good bits that got left behind.
Python provides a number of features that are not really necessary—you
can write good code without them—but with them you can sometimes write
code that’s more concise, readable or efficient, and sometimes all
three.

## Conditional expressions

We saw conditional statements in Section
[Conditional execution](./conditionals_and_recursion.md#conditional-execution).
Conditional statements are often used to choose one of two values; for
example:

```ruby
if x > 0:
    y = math.log(x)
else:
    y = float('nan')
```

This statement checks whether `x` is positive. If so, it
computes `math.log`. If not, `math.log` would
raise a ValueError. To avoid stopping the program, we generate a “NaN”,
which is a special floating-point value that represents “Not a Number”.

We can write this statement more concisely using a **conditional
expression**:

```ruby
y = math.log(x) if x > 0 else float('nan')
```

You can almost read this line like English: “`y` gets
log-`x` if `x` is greater than 0; otherwise it gets NaN”.

Recursive functions can sometimes be rewritten using conditional
expressions. For example, here is a recursive version of
`factorial`:

```ruby
def factorial(n):
    if n == 0:
        return 1
    else:
        return n * factorial(n-1)
```

We can rewrite it like this:

```ruby
def factorial(n):
    return 1 if n == 0 else n * factorial(n-1)
```

Another use of conditional expressions is handling optional arguments.
For example, here is the init method from `GoodKangaroo` (see
[Exercises](./classes_and_methods.md#exercises) from Classes and methods
chapter):

```ruby
def __init__(self, name, contents=None):
    self.name = name
    if contents == None:
        contents = []
    self.pouch_contents = contents
```

We can rewrite this one like this:

```ruby
def __init__(self, name, contents=None):
    self.name = name
    self.pouch_contents = [] if contents == None else contents 
```

In general, you can replace a conditional statement with a conditional
expression if both branches contain simple expressions that are either
returned or assigned to the same variable.

## List comprehensions

In Section [Map, filter and reduce](./arrays.md#map-filter-and-reduce)
we saw the map and filter patterns. For example, this function takes a
list of strings, maps the string method `capitalize` to the elements,
and returns a new list of strings:

```ruby
def capitalize_all(t):
    res = []
    for s in t:
        res.append(s.capitalize())
    return res
```

We can write this more concisely using a **list comprehension**:

```ruby
def capitalize_all(t):
    return [s.capitalize() for s in t]
```

The bracket operators indicate that we are constructing a new list. The
expression inside the brackets specifies the elements of the list, and
the `for` clause indicates what sequence we are traversing.

The syntax of a list comprehension is a little awkward because the loop
variable, `s` in this example, appears in the expression
before we get to the definition.

List comprehensions can also be used for filtering. For example, this
function selects only the elements of `t` that are upper
case, and returns a new list:

```ruby
def only_upper(t):
    res = []
    for s in t:
        if s.isupper():
            res.append(s)
    return res
```

We can rewrite it using a list comprehension

```ruby
def only_upper(t):
    return [s for s in t if s.isupper()]
```

List comprehensions are concise and easy to read, at least for simple
expressions. And they are usually faster than the equivalent for loops,
sometimes much faster. So if you are mad at me for not mentioning them
earlier, I understand.

But, in my defense, list comprehensions are harder to debug because you
can’t put a print statement inside the loop. I suggest that you use them
only if the computation is simple enough that you are likely to get it
right the first time. And for beginners that means never.

## Generator expressions

**Generator expressions** are similar to list
comprehensions, but with parentheses instead of square brackets:

```ruby
>>> g = (x**2 for x in range(5))
>>> g
<generator object <genexpr> at 0x7f4c45a786c0>
```

The result is a generator object that knows how to iterate through a
sequence of values. But unlike a list comprehension, it does not compute
the values all at once; it waits to be asked. The built-in function
`next` gets the next value from the generator:

```ruby
>>> next(g)
0
>>> next(g)
1
```

When you get to the end of the sequence, `next` raises a
StopIteration exception. You can also use a `for` loop to
iterate through the values:

```ruby
>>> for val in g:
...     print(val)
4
9
16
```

The generator object keeps track of where it is in the sequence, so the
`for` loop picks up where `next` left off. Once
the generator is exhausted, it continues to raise
`StopIteration`:

```ruby
>>> next(g)
StopIteration
```

Generator expressions are often used with functions like
`sum`, `max`, and `min`:

```ruby
>>> sum(x**2 for x in range(5))
30
```

## any and all

Python provides a built-in function, `any`, that takes a
sequence of boolean values and returns `True` if any of the
values are ` True`. It works on lists:

```ruby
>>> any([False, False, True])
True
```

But it is often used with generator expressions:

```ruby
>>> any(letter == 't' for letter in 'monty')
True
```

That example isn’t very useful because it does the same thing as the
`in` operator. But we could use `any` to rewrite
some of the search functions we wrote in Section
[Search](./case_study_word_play.md#search).
For example, we could write `avoids?` like this:

```ruby
def avoids?(word, forbidden):
    return not any(letter in forbidden for letter in word)
```

The function almost reads like English, “`word` avoids?
`forbidden` if there are not any forbidden letters in
`word`.”

Using `any` with a generator expression is efficient because
it stops immediately if it finds a `True` value, so it
doesn’t have to evaluate the whole sequence.

Python provides another built-in function, `all`, that
returns `True` if every element of the sequence is
`True`. As an exercise, use `all` to re-write `uses_all?`
from Section [Search](./case_study_word_play.md#search).

## Sets

In Section [Hash subtraction](./case_study_data_structure_selection.md#hash-subtraction)
I use dictionaries to find the words that appear in a document but not in
a word list. The function I wrote takes `d1`, which contains the words
from the document as keys, and `d2`, which contains the list of words. It
returns a dictionary that contains the keys from `d1` that are not in `d2`.

```ruby
def subtract(d1, d2):
    res = dict()
    for key in d1:
        if key not in d2:
            res[key] = None
    return res
```

In all of these dictionaries, the values are `None` because
we never use them. As a result, we waste some storage space.

Python provides another built-in type, called a `set`, that
behaves like a collection of dictionary keys with no values. Adding
elements to a set is fast; so is checking membership. And sets provide
methods and operators to compute common set operations.

For example, set subtraction is available as a method called
`difference` or as an operator, `-`. So we can
rewrite `subtract` like this:

```ruby
def subtract(d1, d2):
    return set(d1) - set(d2)
```

The result is a set instead of a dictionary, but for operations like
iteration, the behavior is the same.

Some of the exercises in this book can be done concisely and efficiently
with sets. For example, here is a solution to `has_duplicates?`, from
[Exercises](./arrays.md#exercises) of Arrays chapter, that uses a dictionary:

```ruby
def has_duplicates?(t):
    d = {}
    for x in t:
        if x in d:
            return True
        d[x] = True
    return False
```

When an element appears for the first time, it is added to the
dictionary. If the same element appears again, the function returns
`True`.

Using sets, we can write the same function like this:

```ruby
def has_duplicates?(t):
    return len(set(t)) < len(t)
```

An element can only appear in a set once, so if an element in
`t` appears more than once, the set will be smaller than
`t`. If there are no duplicates, the set will be the same
size as `t`.

We can also use sets to do some of the exercises in
Chapter [Case study: word play](./case_study_word_play.md). For
example, here’s a version of `uses_only?` with a loop:

```ruby
def uses_only?(word, available):
    for letter in word: 
        if letter not in available:
            return False
    return True
```

`uses_only?` checks whether all letters in `word` are in
`available`. We can rewrite it like this:

```ruby
def uses_only?(word, available):
    return set(word) <= set(available)
```

The `<=` operator checks whether one set is a subset or another,
including the possibility that they are equal, which is true if all the
letters in `word` appear in `available`.

As an exercise, rewrite `avoids?` using sets.

## Counters

A Counter is like a set, except that if an element appears more than
once, the Counter keeps track of how many times it appears. If you are
familiar with the mathematical idea of a **multiset**, a
Counter is a natural way to represent a multiset.

Counter is defined in a standard module called `collections`,
so you have to import it. You can initialize a Counter with a string,
list, or anything else that supports iteration:

```ruby
>>> from collections import Counter
>>> count = Counter('parrot')
>>> count
Counter({'r': 2, 't': 1, 'o': 1, 'p': 1, 'a': 1})
```

Counters behave like dictionaries in many ways; they map from each key
to the number of times it appears. As in dictionaries, the keys have to
be hashable.

Unlike dictionaries, Counters don’t raise an exception if you access an
element that doesn’t appear. Instead, they return 0:

```ruby
>>> count['d']
0
```

We can use Counters to rewrite `anagram?` from
[Exercises](./arrays.md#exercises) of Arrays chapter:

```ruby
def anagram?(word1, word2):
    return Counter(word1) == Counter(word2)
```

If two words are anagrams, they contain the same letters with the same
counts, so their Counters are equivalent.

Counters provide methods and operators to perform set-like operations,
including addition, subtraction, union and intersection. And they
provide an often-useful method, `most_common`, which returns a list of
value-frequency pairs, sorted from most common to least:

```ruby
>>> count = Counter('parrot')
>>> for val, freq in count.most_common(3):
...     print(val, freq)
r 2
p 1
a 1
```

## defaultdict

The `collections` module also provides
`defaultdict`, which is like a dictionary except that if you
access a key that doesn’t exist, it can generate a new value on the fly.

When you create a defaultdict, you provide a function that’s used to
create new values. A function used to create objects is sometimes called
a **factory**. The built-in functions that create lists,
sets, and other types can be used as factories:

```ruby
>>> from collections import defaultdict
>>> d = defaultdict(list)
```

Notice that the argument is `list`, which is a class object,
not `list()`, which is a new list. The function you provide
doesn’t get called unless you access a key that doesn’t exist.

```ruby
>>> t = d['new key']
>>> t
[]
```

The new list, which we’re calling `t`, is also added to the
dictionary. So if we modify `t`, the change appears in
`d`:

```ruby
>>> t.append('new value')
>>> d
defaultdict(<class 'list'>, {'new key': ['new value']})
```

If you are making a dictionary of lists, you can often write simpler
code using `defaultdict`. In my solution to
[Exercises](./arrays_and_hashes.md#exercises) of Arrays and Hashes chapter,
which you can get from
http://thinkpython2.com/code/anagram_sets.py, I make a dictionary that
maps from a sorted string of letters to the list of words that can be
spelled with those letters. For example, `’opst’` maps to
the list `[’opts’, ’post’, ’pots’, ’spot’, ’stop’, ’tops’]`.

Here’s the original code:

```ruby
def all_anagrams(filename):
    d = {}
    for line in open(filename):
        word = line.strip().lower()
        t = signature(word)
        if t not in d:
            d[t] = [word]
        else:
            d[t].append(word)
    return d
```

This can be simplified using `setdefault`, which you might
have used in [Exercises](./hashes.md#exercises) of Hashes chapter:

```ruby
def all_anagrams(filename):
    d = {}
    for line in open(filename):
        word = line.strip().lower()
        t = signature(word)
        d.setdefault(t, []).append(word)
    return d
```

This solution has the drawback that it makes a new list every time,
regardless of whether it is needed. For lists, that’s no big deal, but
if the factory function is complicated, it might be.

We can avoid this problem and simplify the code using a
`defaultdict`:

```ruby
def all_anagrams(filename):
    d = defaultdict(list)
    for line in open(filename):
        word = line.strip().lower()
        t = signature(word)
        d[t].append(word)
    return d
```

My solution to [Exercises](./inheritance.md#exercises) of Inheritance chapter,
which you can download from
http://thinkpython2.com/code/PokerHandSoln.py, uses
`setdefault` in the function `has_straightflush`. This
solution has the drawback of creating a `Hand` object every
time through the loop, whether it is needed or not. As an exercise,
rewrite it using a defaultdict.

## Named tuples

Many simple objects are basically collections of related values. For
example, the Point object defined in Chapter
[Classes and objects](./classes_and_objects.md) contains
two numbers, `x` and `y`. When you define a class
like this, you usually start with an init method and a str method:

```ruby
class Point:

    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y

    def __str__(self):
        return '(%g, %g)' % (self.x, self.y)
```

This is a lot of code to convey a small amount of information. Python
provides a more concise way to say the same thing:

```ruby
from collections import namedtuple
Point = namedtuple('Point', ['x', 'y'])
```

The first argument is the name of the class you want to create. The
second is a list of the attributes Point objects should have, as
strings. The return value from `namedtuple` is a class
object:

```ruby
>>> Point
<class '__main__.Point'>
```

`Point` automatically provides methods like `__init__` and
`__str__` so you don’t have to write them.

To create a Point object, you use the Point class as a function:

```ruby
>>> p = Point(1, 2)
>>> p
Point(x=1, y=2)
```

The init method assigns the arguments to attributes using the names you
provided. The str method prints a representation of the Point object and
its attributes.

You can access the elements of the named tuple by name:

```ruby
>>> p.x, p.y
(1, 2)
```

But you can also treat a named tuple as a tuple:

```ruby
>>> p[0], p[1]
(1, 2)

>>> x, y = p
>>> x, y
(1, 2)
```

Named tuples provide a quick way to define simple classes. The drawback
is that simple classes don’t always stay simple. You might decide later
that you want to add methods to a named tuple. In that case, you could
define a new class that inherits from the named tuple:

```ruby
class Pointier(Point):
    # add more methods here
```

Or you could switch to a conventional class definition.

## Gathering keyword args

In Section
[Variable-length argument array](./arrays_and_hashes.md#variable-length-argument-array),
we saw how to write a function that gathers its arguments into a tuple:

```ruby
def printall(*args):
    print(args)
```

You can call this function with any number of positional arguments (that
is, arguments that don’t have keywords):

```ruby
>>> printall(1, 2.0, '3')
(1, 2.0, '3')
```

But the operator doesn’t gather keyword arguments:

```ruby
>>> printall(1, 2.0, third='3')
TypeError: printall() got an unexpected keyword argument 'third'
```

To gather keyword arguments, you can use the `*` operator:

```ruby
def printall(*args, **kwargs):
    print(args, kwargs)
```

You can call the keyword gathering parameter anything you want, but
`kwargs` is a common choice. The result is a dictionary that
maps keywords to values:

```ruby
>>> printall(1, 2.0, third='3')
(1, 2.0) {'third': '3'}
```

If you have a dictionary of keywords and values, you can use the scatter
operator, `*` to call a function:

```ruby
>>> d = dict(x=1, y=2)
>>> Point(**d)
Point(x=1, y=2)
```

Without the scatter operator, the function would treat `d` as
a single positional argument, so it would assign `d` to
`x` and complain because there’s nothing to assign to `y`:

```ruby
>>> d = dict(x=1, y=2)
>>> Point(d)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: __new__() missing 1 required positional argument: 'y'
```

When you are working with functions that have a large number of
parameters, it is often useful to create and pass around dictionaries
that specify frequently used options.

## Glossary

  - **conditional expression**:  
    An expression that has one of two values, depending on a condition.

  - **list comprehension**:  
    An expression with a `for` loop in square brackets that
    yields a new list.

  - **generator expression**:  
    An expression with a `for` loop in parentheses that
    yields a generator object.

  - **multiset**:  
    A mathematical entity that represents a mapping between the elements
    of a set and the number of times they appear.

  - **factory**:  
    A function, usually passed as a parameter, used to create objects.

## Exercises

**Exercise 1**  
The following is a function computes the binomial coefficient
recursively.

```ruby
def binomial_coeff(n, k):
    """Compute the binomial coefficient "n choose k".

    n: number of trials
    k: number of successes

    returns: int
    """
    if k == 0:
        return 1
    if n == 0:
        return 0

    res = binomial_coeff(n-1, k) + binomial_coeff(n-1, k-1)
    return res
```

Rewrite the body of the function using nested conditional expressions.

One note: this function is not very efficient because it ends up
computing the same values over and over. You could make it more
efficient by memoizing (see Section [Memos](./hashes.md#memos)). But you
will find that it’s harder to memoize if you write it using conditional
expressions.

