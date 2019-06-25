# Debugging

When you are debugging, you should distinguish among different kinds of
errors in order to track them down more quickly:

  - Syntax errors are discovered by the interpreter when it is
    translating the source code into byte code. They indicate that there
    is something wrong with the structure of the program. Example:
    Omitting the colon at the end of a `def` statement
    generates the somewhat redundant message `SyntaxError: invalid
    syntax`.

  - Runtime errors are produced by the interpreter if something goes
    wrong while the program is running. Most runtime error messages
    include information about where the error occurred and what
    functions were executing. Example: An infinite recursion eventually
    causes the runtime error “maximum recursion depth exceeded”.

  - Semantic errors are problems with a program that runs without
    producing error messages but doesn’t do the right thing. Example: An
    expression may not be evaluated in the order you expect, yielding an
    incorrect result.

The first step in debugging is to figure out which kind of error you are
dealing with. Although the following sections are organized by error
type, some techniques are applicable in more than one situation.

## Syntax errors

Syntax errors are usually easy to fix once you figure out what they are.
Unfortunately, the error messages are often not helpful. The most common
messages are `SyntaxError: invalid syntax` and
`SyntaxError: invalid token`, neither of which is very
informative.

On the other hand, the message does tell you where in the program the
problem occurred. Actually, it tells you where Python noticed a problem,
which is not necessarily where the error is. Sometimes the error is
prior to the location of the error message, often on the preceding line.

If you are building the program incrementally, you should have a good
idea about where the error is. It will be in the last line you added.

If you are copying code from a book, start by comparing your code to the
book’s code very carefully. Check every character. At the same time,
remember that the book might be wrong, so if you see something that
looks like a syntax error, it might be.

Here are some ways to avoid the most common syntax errors:

1.  Make sure you are not using a Python keyword for a variable name.

2.  Check that you have a colon at the end of the header of every
    compound statement, including `for`, `while`,
    `if`, and `def` statements.

3.  Make sure that any strings in the code have matching quotation
    marks. Make sure that all quotation marks are "straight quotes", not
    “curly quotes”.

4.  If you have multiline strings with triple quotes (single or double),
    make sure you have terminated the string properly. An unterminated
    string may cause an `invalid token` error at the end of
    your program, or it may treat the following part of the program as a
    string until it comes to the next string. In the second case, it
    might not produce an error message at all!

5.  An unclosed opening operator—`(`, `{`, or `[`—makes Python continue
    with the next line as part of the current statement. Generally, an
    error occurs almost immediately in the next line.

6.  Check for the classic `=` instead of `==`
    inside a conditional.

7.  Check the indentation to make sure it lines up the way it is
    supposed to. Python can handle space and tabs, but if you mix them
    it can cause problems. The best way to avoid this problem is to use
    a text editor that knows about Python and generates consistent
    indentation.

8.  If you have non-ASCII characters in the code (including strings and
    comments), that might cause a problem, although Python 3 usually
    handles non-ASCII characters. Be careful if you paste in text from a
    web page or other source.

If nothing works, move on to the next section...

### I keep making changes and it makes no difference.

If the interpreter says there is an error and you don’t see it, that
might be because you and the interpreter are not looking at the same
code. Check your programming environment to make sure that the program
you are editing is the one Python is trying to run.

If you are not sure, try putting an obvious and deliberate syntax error
at the beginning of the program. Now run it again. If the interpreter
doesn’t find the new error, you are not running the new code.

There are a few likely culprits:

  - You edited the file and forgot to save the changes before running it
    again. Some programming environments do this for you, but some
    don’t.

  - You changed the name of the file, but you are still running the old
    name.

  - Something in your development environment is configured incorrectly.

  - If you are writing a module and using `import`, make sure
    you don’t give your module the same name as one of the standard
    Python modules.

  - If you are using `import` to read a module, remember that
    you have to restart the interpreter or use `reload` to
    read a modified file. If you import the module again, it doesn’t do
    anything.

If you get stuck and you can’t figure out what is going on, one approach
is to start again with a new program like “Hello, World!”, and make
sure you can get a known program to run. Then gradually add the pieces
of the original program to the new one.

## Runtime errors

Once your program is syntactically correct, Python can read it and at
least start running it. What could possibly go wrong?

### My program does absolutely nothing.

This problem is most common when your file consists of functions and
classes but does not actually invoke a function to start execution. This
may be intentional if you only plan to import this module to supply
classes and functions.

If it is not intentional, make sure there is a function call in the
program, and make sure the flow of execution reaches it (see “Flow of
Execution” below).

### My program hangs.

If a program stops and seems to be doing nothing, it is “hanging”. Often
that means that it is caught in an infinite loop or infinite recursion.

  - If there is a particular loop that you suspect is the problem, add a
    `print` statement immediately before the loop that says
    “entering the loop” and another immediately after that says
    “exiting the loop”.
    
    Run the program. If you get the first message and not the second,
    you’ve got an infinite loop. Go to the “Infinite Loop” section
    below.

  - Most of the time, an infinite recursion will cause the program to
    run for a while and then produce a “RuntimeError: Maximum recursion
    depth exceeded” error. If that happens, go to the “Infinite
    Recursion” section below.
    
    If you are not getting this error but you suspect there is a problem
    with a recursive method or function, you can still use the
    techniques in the “Infinite Recursion” section.

  - If neither of those steps works, start testing other loops and other
    recursive functions and methods.

  - If that doesn’t work, then it is possible that you don’t understand
    the flow of execution in your program. Go to the “Flow of Execution”
    section below.

**Infinite Loop**

If you think you have an infinite loop and you think you know what loop
is causing the problem, add a `print` statement at the end of
the loop that prints the values of the variables in the condition and
the value of the condition.

For example:

```ruby
while x > 0 and y < 0 :
    # do something to x
    # do something to y

    print('x: ', x)
    print('y: ', y)
    print("condition: ", (x > 0 and y < 0))
```

Now when you run the program, you will see three lines of output for
each time through the loop. The last time through the loop, the
condition should be `False`. If the loop keeps going, you
will be able to see the values of `x` and `y`, and
you might figure out why they are not being updated correctly.

**Infinite Recursion**

Most of the time, infinite recursion causes the program to run for a
while and then produce a `Maximum recursion depth exceeded`
error.

If you suspect that a function is causing an infinite recursion, make
sure that there is a base case. There should be some condition that
causes the function to return without making a recursive invocation. If
not, you need to rethink the algorithm and identify a base case.

If there is a base case but the program doesn’t seem to be reaching it,
add a `print` statement at the beginning of the function that
prints the parameters. Now when you run the program, you will see a few
lines of output every time the function is invoked, and you will see the
parameter values. If the parameters are not moving toward the base case,
you will get some ideas about why not.

**Flow of Execution**

If you are not sure how the flow of execution is moving through your
program, add `print` statements to the beginning of each
function with a message like “entering function `foo`”, where
`foo` is the name of the function.

Now when you run the program, it will print a trace of each function as
it is invoked.

### When I run the program I get an exception.

If something goes wrong during runtime, Python prints a message that
includes the name of the exception, the line of the program where the
problem occurred, and a traceback.

The traceback identifies the function that is currently running, and
then the function that called it, and then the function that called
*that*, and so on. In other words, it traces the sequence
of function calls that got you to where you are, including the line
number in your file where each call occurred.

The first step is to examine the place in the program where the error
occurred and see if you can figure out what happened. These are some of
the most common runtime errors:

  - **NameError**:  
    You are trying to use a variable that doesn’t exist in the current
    environment. Check if the name is spelled right, or at least
    consistently. And remember that local variables are local; you
    cannot refer to them from outside the function where they are
    defined.

  - **TypeError**:  
    There are several possible causes:
    
      - You are trying to use a value improperly. Example: indexing a
        string, list, or tuple with something other than an integer.
    
      - There is a mismatch between the items in a format string and the
        items passed for conversion. This can happen if either the
        number of items does not match or an invalid conversion is
        called for.
    
      - You are passing the wrong number of arguments to a function. For
        methods, look at the method definition and check that the first
        parameter is `self`. Then look at the method
        invocation; make sure you are invoking the method on an object
        with the right type and providing the other arguments correctly.

  - **KeyError**:  
    You are trying to access an element of a dictionary using a key that
    the dictionary does not contain. If the keys are strings, remember
    that capitalization matters.

  - **AttributeError**:  
    You are trying to access an attribute or method that does not exist.
    Check the spelling! You can use the built-in function
    `vars` to list the attributes that do exist.
    
    If an AttributeError indicates that an object has
    `NoneType`, that means that it is `None`. So
    the problem is not the attribute name, but the object.
    
    The reason the object is none might be that you forgot to return a
    value from a function; if you get to the end of a function without
    hitting a `return` statement, it returns
    `None`. Another common cause is using the result from a
    list method, like `sort`, that returns `None`.

  - **IndexError**:  
    The index you are using to access a list, string, or tuple is
    greater than its length minus one. Immediately before the site of
    the error, add a `print` statement to display the value
    of the index and the length of the array. Is the array the right
    size? Is the index the right value?

The Python debugger (`pdb`) is useful for tracking down
exceptions because it allows you to examine the state of the program
immediately before the error. You can read about `pdb` at
https://docs.python.org/3/library/pdb.html.

### I added so many print statements I get inundated with output.

One of the problems with using `print` statements for
debugging is that you can end up buried in output. There are two ways to
proceed: simplify the output or simplify the program.

To simplify the output, you can remove or comment out `print`
statements that aren’t helping, or combine them, or format the output so
it is easier to understand.

To simplify the program, there are several things you can do. First,
scale down the problem the program is working on. For example, if you
are searching a list, search a *small* list. If the program
takes input from the user, give it the simplest input that causes the
problem.

Second, clean up the program. Remove dead code and reorganize the
program to make it as easy to read as possible. For example, if you
suspect that the problem is in a deeply nested part of the program, try
rewriting that part with simpler structure. If you suspect a large
function, try splitting it into smaller functions and testing them
separately.

Often the process of finding the minimal test case leads you to the bug.
If you find that a program works in one situation but not in another,
that gives you a clue about what is going on.

Similarly, rewriting a piece of code can help you find subtle bugs. If
you make a change that you think shouldn’t affect the program, and it
does, that can tip you off.

## Semantic errors

In some ways, semantic errors are the hardest to debug, because the
interpreter provides no information about what is wrong. Only you know
what the program is supposed to do.

The first step is to make a connection between the program text and the
behavior you are seeing. You need a hypothesis about what the program is
actually doing. One of the things that makes that hard is that computers
run so fast.

You will often wish that you could slow the program down to human speed,
and with some debuggers you can. But the time it takes to insert a few
well-placed `print` statements is often short compared to
setting up the debugger, inserting and removing breakpoints, and
“stepping” the program to where the error is occurring.

### My program doesn’t work.

You should ask yourself these questions:

  - Is there something the program was supposed to do but which doesn’t
    seem to be happening? Find the section of the code that performs
    that function and make sure it is executing when you think it
    should.

  - Is something happening that shouldn’t? Find code in your program
    that performs that function and see if it is executing when it
    shouldn’t.

  - Is a section of code producing an effect that is not what you
    expected? Make sure that you understand the code in question,
    especially if it involves functions or methods in other Python
    modules. Read the documentation for the functions you call. Try them
    out by writing simple test cases and checking the results.

In order to program, you need a mental model of how programs work. If
you write a program that doesn’t do what you expect, often the problem
is not in the program; it’s in your mental model.

The best way to correct your mental model is to break the program into
its components (usually the functions and methods) and test each
component independently. Once you find the discrepancy between your
model and reality, you can solve the problem.

Of course, you should be building and testing components as you develop
the program. If you encounter a problem, there should be only a small
amount of new code that is not known to be correct.

### I’ve got a big hairy expression and it doesn’t do what I expect.

Writing complex expressions is fine as long as they are readable, but
they can be hard to debug. It is often a good idea to break a complex
expression into a series of assignments to temporary variables.

For example:

```ruby
self.hands[i].addCard(self.hands[self.findNeighbor(i)].popCard())
```

This can be rewritten as:

```ruby
neighbor = self.findNeighbor(i)
pickedCard = self.hands[neighbor].popCard()
self.hands[i].addCard(pickedCard)
```

The explicit version is easier to read because the variable names
provide additional documentation, and it is easier to debug because you
can check the types of the intermediate variables and display their
values.

Another problem that can occur with big expressions is that the order of
evaluation may not be what you expect. For example, if you are
translating the expression `x/2 π` into Python, you might
write:

```ruby
y = x / 2 * math.pi
```

That is not correct because multiplication and division have the same
precedence and are evaluated from left to right. So this expression
computes `x π / 2`.

A good way to debug expressions is to add parentheses to make the order
of evaluation explicit:

```ruby
y = x / (2 * math.pi)
```

Whenever you are not sure of the order of evaluation, use parentheses.
Not only will the program be correct (in the sense of doing what you
intended), it will also be more readable for other people who haven’t
memorized the order of operations.

### I’ve got a function that doesn’t return what I expect.

If you have a `return` statement with a complex expression,
you don’t have a chance to print the result before returning. Again, you
can use a temporary variable. For example, instead of:

```ruby
return self.hands[i].removeMatches()
```

you could write:

```ruby
count = self.hands[i].removeMatches()
return count
```

Now you have the opportunity to display the value of `count`
before returning.

### I’m really, really stuck and I need help.

First, try getting away from the computer for a few minutes. Computers
emit waves that affect the brain, causing these symptoms:

  - Frustration and rage.

  - Superstitious beliefs (“the computer hates me”) and magical thinking
    (“the program only works when I wear my hat backward”).

  - Random walk programming (the attempt to program by writing every
    possible program and choosing the one that does the right thing).

If you find yourself suffering from any of these symptoms, get up and go
for a walk. When you are calm, think about the program. What is it
doing? What are some possible causes of that behavior? When was the last
time you had a working program, and what did you do next?

Sometimes it just takes time to find a bug. I often find bugs when I am
away from the computer and let my mind wander. Some of the best places
to find bugs are trains, showers, and in bed, just before you fall
asleep.

### No, I really need help.

It happens. Even the best programmers occasionally get stuck. Sometimes
you work on a program so long that you can’t see the error. You need a
fresh pair of eyes.

Before you bring someone else in, make sure you are prepared. Your
program should be as simple as possible, and you should be working on
the smallest input that causes the error. You should have
`print` statements in the appropriate places (and the output
they produce should be comprehensible). You should understand the
problem well enough to describe it concisely.

When you bring someone in to help, be sure to give them the information
they need:

  - If there is an error message, what is it and what part of the
    program does it indicate?

  - What was the last thing you did before this error occurred? What
    were the last lines of code that you wrote, or what is the new test
    case that fails?

  - What have you tried so far, and what have you learned?

When you find the bug, take a second to think about what you could have
done to find it faster. Next time you see something similar, you will be
able to find the bug more quickly.

Remember, the goal is not just to make the program work. The goal is to
learn how to make the program work.

