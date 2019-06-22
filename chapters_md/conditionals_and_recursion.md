# Conditionals and recursion

The main topic of this chapter is the `if` statement, which
executes different code depending on the state of the program. But first
I want to discuss about floor division and introduce a new operator:
modulus.

## Floor division and modulus

The **division** operator, `/`, divides two numbers and
rounds down to an integer if both operands are integers. For example,
suppose the run time of a movie is 105 minutes. You might want to know
how long that is in hours.

```ruby
>> minutes = 105
=> 105
>> hours = minutes / 60
=> 1
```

We don’t normally write hours with decimal points. If it is needed for
some reason, at least one of the operands should be a floating-point
value:

```ruby
>> minutes / 60.0
=> 1.75
>> Float(minutes) / 60
=> 1.75
```

To get the remainder, you could subtract off one hour in minutes:

```ruby
>> remainder = minutes - hours * 60
=> 45
```

An alternative is to use the **modulus operator**, `%`,
which divides two numbers and returns the remainder.

```ruby
>> remainder = minutes % 60
=> 45
```

The modulus operator is more useful than it seems. For example, you can
check whether one number is divisible by another—if `x % y`
is zero, then `x` is divisible by `y`.

Also, you can extract the right-most digit or digits from a number. For
example, `x % 10` yields the right-most digit of
`x` (in base 10). Similarly `x % 100` yields the
last two digits.

## Boolean expressions

A **boolean expression** is an expression that is either
true or false. The following examples use the operator `==`,
which compares two operands and produces `true` if they are
equal and `false` otherwise:

```ruby
>> 5 == 5
=> true
>> 5 == 6
=> false
```

`true` and `false` are special values that belong
to the type `TrueClass` and `FalseClass`
respectively; they are not strings:

```ruby
>> true.class
=> TrueClass
>> false.class
=> FalseClass
```

The `==` operator is one of the **relational
operators**; the others are:

``` 
      x != y               # x is not equal to y
      x > y                # x is greater than y
      x < y                # x is less than y
      x >= y               # x is greater than or equal to y
      x <= y               # x is less than or equal to y
```

Although these operations are probably familiar to you, the Ruby symbols
are different from the mathematical symbols. A common error is to use a
single equal sign (`=`) instead of a double equal sign
(`==`). Remember that `=` is an assignment
operator and `==` is a relational operator.

## Logical operators

There are three **logical operators** useful in boolean
expressions: `&&`, `||`, and `!`. For
example, `x > 0 && x < 10` is true only if `x`
is greater than 0 *and* less than 10.

`n%2 == 0 || n%3 == 0` is true if *either or
both* of the conditions is true, that is, if the number is
divisible by 2 *or* 3.

Finally, the `!` operator negates a boolean expression, so
`!(x > y)` is true if `x > y` is false, that
is, if `x` is less than or equal to `y`.

In Ruby, the operands of the logical operators need not be boolean
expressions:

```ruby
>> a = 42 && true
=> true
>> a
=> true
```

This flexibility can be useful, but there are some subtleties to it that
might be confusing. You might want to avoid it (unless you know what you
are doing).

## Conditional execution

In order to write useful programs, we almost always need the ability to
check conditions and change the behavior of the program accordingly.
**Conditional statements** give us this ability. The
simplest form is the `if` statement:

```ruby
if x > 0
  puts 'x is positive'
end
```

The boolean expression after `if` is called the
**condition**. If it is true, the body of `if`
statement runs. If not, nothing happens.

`if` statements have the same structure as method
definitions: a header followed by body (indented two spaces by
convention) and end keyword. Statements like this are called
**compound statements**.

There is no limit on the number of statements that can appear in the
body, and can be empty too. Occasionally, it is useful to have a body
with no statements (usually as a place keeper for code you haven’t
written yet).

```ruby
if x < 0
  # TODO: need to handle negative values!
end
```

`if` can also be specified after an expression to make it
conditional.

```ruby
>> puts '2 is less than 1' if 2 < 1
=> nil
>> puts '2 is less than 3' if 2 < 3
2 is less than 3
=> nil
```

## Alternative execution

A second form of the `if` statement is “alternative
execution”, in which there are two possibilities and the condition
determines which one runs. The syntax looks like this:

```ruby
if x % 2 == 0
  puts 'x is even'
else
  puts 'x is odd'
end
```

If the remainder when `x` is divided by 2 is 0, then we know
that `x` is even, and the program displays an appropriate
message. If the condition is false, the second set of statements runs.
Since the condition must be true or false, exactly one of the
alternatives will run. The alternatives are called **branches**,
because they are branches in the flow of execution.

## Chained conditionals

Sometimes there are more than two possibilities and we need more than
two branches. One way to express a computation like that is a
**chained conditional**:

```ruby
if x < y
  puts 'x is less than y'
elsif x > y
  puts 'x is greater than y'
else
  puts 'x and y are equal'
end
```

`elsif` is an abbreviation of “else if”. Again, exactly one
branch will run. There is no limit on the number of `elsif`
statements. If there is an `else` clause, it has to be at the
end, but there doesn’t have to be one.

```ruby
if choice == 'a'
  draw_a()
elsif choice == 'b'
  draw_b()
elsif choice == 'c'
  draw_c()
end
```

Each condition is checked in order. If the first is false, the next is
checked, and so on. If one of them is true, the corresponding branch
runs and the statement ends. Even if more than one condition is true,
only the first true branch runs.

## Nested conditionals

One conditional can also be nested within another. We could have written
the example in the previous section like this:

```ruby
if x == y
  puts 'x and y are equal'
else
  if x < y
    puts 'x is less than y'
  else
    puts 'x is greater than y'
  end
end
```

The outer conditional contains two branches. The first branch contains a
simple statement. The second branch contains another `if`
statement, which has two branches of its own. Those two branches are
both simple statements, although they could have been conditional
statements as well.

Although the indentation of the statements makes the structure apparent,
**nested conditionals** become difficult to read very
quickly. It is a good idea to avoid them when you can.

Logical operators often provide a way to simplify nested conditional
statements. For example, we can rewrite the following code using a
single conditional:

```ruby
if 0 < x
  if x < 10
    puts 'x is a positive single-digit number.'
  end
end
```

The `puts` method runs only if we make it past both
conditionals, so we can get the same effect with the `&&`
operator:

```ruby
if 0 < x && x < 10
  puts 'x is a positive single-digit number.'
end
```

## Recursion

It is legal for one method to call another; it is also legal for a
method to call itself. It may not be obvious why that is a good thing,
but it turns out to be one of the most magical things a program can do.
For example, look at the following method:

```ruby
def countdown(n)
  if n <= 0
    puts 'Blastoff!'
  else
    puts n
    countdown(n-1)
  end
end
```

If `n` is 0 or negative, it outputs the word, “Blastoff!”
Otherwise, it outputs `n` and then calls a method named
`countdown`—itself—passing `n-1` as an argument.

What happens if we call this method like this?

```ruby
countdown(3)
```

The execution of `countdown` begins with `n=3`,
and since `n` is greater than 0, it outputs the value 3, and
then calls itself...

> The execution of `countdown` begins with `n=2`,
> and since `n` is greater than 0, it outputs the value 2,
> and then calls itself...
> 
> > The execution of `countdown` begins with
> > `n=1`, and since `n` is greater than 0, it
> > outputs the value 1, and then calls itself...
> > 
> > > The execution of `countdown` begins with
> > > `n=0`, and since ` n` is not greater than 0,
> > > it outputs the word, “Blastoff!” and then returns.
> > 
> > The `countdown` that got `n=1` returns.
> 
> The `countdown` that got `n=2` returns.

The `countdown` that got `n=3` returns.

And then you’re back in `main`. So, the total output looks like this:

```
3
2
1
Blastoff!
```

A method that calls itself is **recursive**; the process of
executing it is called **recursion**.

As another example, we can write a method that prints a string
`n` times.

```ruby
def print_n(s, n)
  return if n <= 0
  puts s
  print_n(s, n-1)
end
```

If `n <= 0` the **return statement** exits the
method. The flow of execution immediately returns to the caller, and the
remaining lines of the method don’t run.

The rest of the method is similar to `countdown`: it displays
`s` and then calls itself to display `s` `n-1`
additional times. So the number of lines of output is `1 + (n - 1)`,
which adds up to `n`.

For simple examples like this, it is probably easier to use a
`for` loop. But we will see examples later that are hard to write
with a `for` loop and easy to write with recursion, so it is
good to start early.

## Stack diagrams for recursive methods

In [Methods chapter](./methods.md#stack-diagrams),
we used a stack diagram to
represent the state of a program during a method call. The same kind of
diagram can help interpret a recursive method.

Every time a method gets called, Ruby creates a frame to contain the
method’s local variables and parameters. For a recursive method, there
might be more than one frame on the stack at the same time.

Figure below shows a stack diagram for `countdown` called with `n = 3`.

![Stack diagram.](./figs/stack2.png)  
*Figure 5.1: Stack diagram*

As usual, the top of the stack is the frame for `main`. It is empty
because we did not create any variables in `main` or pass any arguments
to it.

The four `countdown` frames have different values for the
parameter `n`. The bottom of the stack, where
`n=0`, is called the **base case**. It does not
make a recursive call, so there are no more frames.

As an exercise, draw a stack diagram for `print_n` called with
`s = 'Hello'` and `n=2`. Then write a method called `do_n` that
takes a method’s symbol and a number, `n`, as arguments, and
that calls the given method `n` times.

## Infinite recursion

If a recursion never reaches a base case, it goes on making recursive
calls forever, and the program never terminates. This is known as
**infinite recursion**, and it is generally not a good
idea. Here is a minimal program with an infinite recursion:

```ruby
def recurse()
  recurse()
end
```

In most programming environments, a program with infinite recursion does
not really run forever. Ruby reports an error message when the maximum
recursion depth is reached:

```ruby
Traceback (most recent call last):
       16: from (irb):2:in `recurse'
       15: from (irb):2:in `recurse'
       14: from (irb):2:in `recurse'
                  .
                  .
                  .
        2: from (irb):2:in `recurse'
        1: from (irb):2:in `recurse'
SystemStackError (stack level too deep)
```

This traceback is a little bigger than the one we saw in the previous
chapter. When the error occurs, there are 16 `recurse` frames
on the stack!

If you encounter an infinite recursion by accident, review your method
to confirm that there is a base case that does not make a recursive
call. And if there is a base case, check whether you are guaranteed to
reach it.

## Keyboard input

The programs we have written so far accept no input from the user. They
just do the same thing every time.

Ruby’s Kernel module provides a method called `gets` that
stops the program and waits for the user to type something. When the
user presses `Enter` key, the program resumes and `gets`
returns what the user typed as a string.

```ruby
>> text = gets
What are you waiting for?
=> "What are you waiting for?\n"
>> text
=> "What are you waiting for?\n"
```

The sequence `\n` at the end of the received string represents a
**newline**, which is a special character that causes a
line break.

As noted before, parentheses are optional for calling methods unless
necessary. Built-in methods, for example `puts` and
`gets`, are often used and leaving out parentheses for them
is conventional.

The `chomp` method can be used on a string object to remove
newline character if it is the last character of string.

```ruby
>> fruit = gets
mango
=> "mango\n"
>> fruit = gets.chomp
apple
=> "apple"
```

Before getting input from the user, it is a good idea to print a prompt
telling the user what to type. Use `print` method instead of
`puts` if line break is not needed.

```ruby
puts 'What...is your name?'
name = gets
```

If you expect the user to type an integer, you can try to convert the
return value to `Integer`:

```ruby
>> puts 'What...is the airspeed velocity of an unladen swallow?'
What...is the airspeed velocity of an unladen swallow?
=> nil
>> speed = gets
42
=> "42\n"
>> Integer(speed)
=> 42
```

But if the user types something other than a string of digits, you get
an error:

```ruby
>> speed = gets
What do you mean, an African or a European swallow?
=> "What do you mean, an African or a European swallow?\n"
>> Integer(speed)
ArgumentError (invalid value for Integer():
    "What do you mean, an African or a European swallow?\n")
```

We will see how to handle this kind of error later.

## Debugging

When a syntax or runtime error occurs, the error message contains a lot
of information, but it can be overwhelming. The most useful parts are
usually:

  - What kind of error it was, and

  - Where it occurred.

Syntax errors are usually easy to find, but there are a few gotchas.

```ruby
>> x = 5
=> 5
>> y = 5x + 4
Traceback (most recent call last):
        1: from /usr/local/bin/irb:11:in `<main>'
SyntaxError ((irb):2: syntax error, unexpected tIDENTIFIER, expecting end-of-input
        y = 5x + 4
             ^)
```

In this example, the problem is missing operator between 5 and x. But
the error message points to `x`, which is misleading. In
general, error messages indicate where the problem was discovered, but
the actual error might be earlier in the code, sometimes on a previous
line.

The same is true of runtime errors. Suppose you are trying to compute a
signal-to-noise ratio in decibels. The formula is
`SNRdb = 10 log10 (Psignal / Pnoise)`. In Ruby, you might
write something like this:

```ruby
signal_power = 9
noise_power = 0
ratio = signal_power / noise_power
decibels = 10 * Math.log10(ratio)
puts decibels
```

When you run this program, you get an exception:

```ruby
Traceback (most recent call last):
    1: from snr.rb:3:in `<main>'
snr.rb:3:in `/': divided by 0 (ZeroDivisionError)
```

The error message indicates line 3, but there is nothing wrong with that
line. To find the real error, it might be useful to print the value of
`noise_power`, which turns out to be 0.

You should take the time to read error messages carefully, but don’t
assume that everything they say is correct.

## Glossary

  - **floor division**:  
    An operation, that divides two integers and rounds down (toward
    negative infinity) to an integer.

  - **modulus operator**:  
    An operator, denoted with a percent sign (`%`), that
    works on integers and returns the remainder when one number is
    divided by another.

  - **boolean expression**:  
    An expression whose value is either `true` or
    `false`.

  - **relational operator**:  
    One of the operators that compares its operands: `==`,
    `!=`, `>`, `<`, `>=`, and `<=`.

  - **logical operator**:  
    One of the operators that combines boolean expressions:
    `&&`, `||`, and `!`.

  - **conditional statement**:  
    A statement that controls the flow of execution depending on some
    condition.

  - **condition**:  
    The boolean expression in a conditional statement that determines
    which branch runs.

  - **compound statement**:  
    A statement that consists of a header, a body and end keyword. The
    body is conventionally indented relative to the header.

  - **branch**:  
    One of the alternative sequences of statements in a conditional
    statement.

  - **chained conditional**:  
    A conditional statement with a series of alternative branches.

  - **nested conditional**:  
    A conditional statement that appears in one of the branches of
    another conditional statement.

  - **return statement**:  
    A statement that causes a method to end immediately and return to
    the caller.

  - **recursion**:  
    The process of calling the method that is currently executing.

  - **base case**:  
    A conditional branch in a recursive method that does not make a
    recursive call.

  - **infinite recursion**:  
    A recursion that doesn’t have a base case, or never reaches it.
    Eventually, an infinite recursion causes a runtime error.

## Exercises

**Exercise 1**  
The `Time` class has methods, `now` and
`to_i`, that returns the current Greenwich Mean Time in “the
epoch”, which is an arbitrary time used as a reference point. On UNIX
systems, the epoch is 1 January 1970.

```ruby
>> Time.now.to_i
=> 1526708312
```

Write a script that reads the current time and converts it to a time of
day in hours, minutes, and seconds, plus the number of days since the
epoch.

**Exercise 2**  
Fermat’s Last Theorem says that there are no positive integers `a`,
`b`, and `c` such that `a**n + b**n = c**n`
for any values of `n` greater than 2.

1.  Write a method named `check_fermat` that takes four
    parameters—`a`, `b`, `c` and
    `n`—and checks to see if Fermat’s theorem holds. If `n`
    is greater than 2 and `a**n + b**n = c**n`
    the program should print, “Holy smokes, Fermat
    was wrong!” Otherwise the program should print, “No, that doesn’t
    work.”

2.  Write a method that prompts the user to input values for
    `a`, `b`, `c` and `n`,
    converts them to integers, and uses `check_fermat` to check whether
    they violate Fermat’s theorem.

**Exercise 3**  
If you are given three sticks, you may or may not be able to arrange
them in a triangle. For example, if one of the sticks is 12 inches long
and the other two are one inch long, you will not be able to get the
short sticks to meet in the middle. For any three lengths, there is a
simple test to see if it is possible to form a triangle:

> If any of the three lengths is greater than the sum of the other two,
> then you cannot form a triangle. Otherwise, you can. (If the sum of
> two lengths equals the third, they form what is called a “degenerate”
> triangle.)

1.  Write a method named `is_triangle` that takes three integers as
    arguments, and that prints either “Yes” or “No”, depending on
    whether you can or cannot form a triangle from sticks with the given
    lengths.

2.  Write a method that prompts the user to input three stick lengths,
    converts them to integers, and uses `is_triangle` to check whether
    sticks with the given lengths can form a triangle.

**Exercise 4**  
What is the output of the following program? Draw a stack diagram that
shows the state of the program when it prints the result.

```ruby
def recurse(n, s)
  if n == 0
    puts s
  else
    recurse(n-1, n+s)
  end
end

recurse(3, 0)
```

1.  What would happen if you called this method like this:
    `recurse(-1, 0)`?

2.  Write comments before body of the method that explains everything
    someone would need to know in order to use this method (and nothing
    else).

