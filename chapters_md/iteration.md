# Iteration

This chapter is about iteration, which is the ability to run a block of
statements repeatedly. We saw a kind of iteration, using recursion, in
Section [recursion](./conditionals_and_recursion.md#recursion). We saw
another kind, using a `for` loop, in Section
[repetition](./case_study_interface_design.md#simple-repetition). In this
chapter we’ll see yet another kind, using a `while` statement.
But first I want to say a little more about variable assignment.

## Reassignment

As you may have discovered, it is legal to make more than one assignment
to the same variable. A new assignment makes an existing variable refer
to a new value (and stop referring to the old value).

```ruby
>> x = 5
=> 5
>> x = 7
=> 7
```

The first time we assign `x`, its value is 5; the second
time, its value is 7.

Figure below shows what **reassignment** looks like in a state diagram.

![State diagram.](./figs/assign2.png)  
*Figure 7.1: State diagram*

At this point I want to address a common source of confusion. Because
Ruby uses the equal sign (`=`) for assignment, it is tempting
to interpret a statement like `a = b` as a mathematical
proposition of equality; that is, the claim that `a` and
`b` are equal. But this interpretation is wrong.

First, equality is a symmetric relationship and assignment is not. For
example, in mathematics, if `a=7` then `7=a`. But in Ruby, the
statement `a = 7` is legal and `7 = a` is not.

Also, in mathematics, a proposition of equality is either true or false
for all time. If `a=b` now, then `a` will always equal `b`. In
Ruby, an assignment statement can make two variables equal, but they
don’t have to stay that way:

```ruby
>> a = 5
=> 5
>> b = a    # a and b are now equal
=> 5
>> a = 3    # a and b are no longer equal
=> 3
>> b
=> 5
```

The third statement changes the value of `a` but does not
change the value of `b`, so they are no longer equal.

Reassigning variables is often useful, but you should use it with
caution. If the values of variables change frequently, it can make the
code difficult to read and debug.

## Updating variables

A common kind of reassignment is an **update**, where the
new value of the variable depends on the old.

```ruby
x = x + 1
```

This means “get the current value of `x`, add one, and then
update `x` with the new value.”

If you try to update a variable that doesn’t exist, you get an error,
because Ruby evaluates the right side before it assigns a value to `x`:

```ruby
>> x = x + 1
NoMethodError (undefined method `+' for nil:NilClass)
```

Before you can update a variable, you have to
**initialize** it, usually with a simple assignment:

```ruby
>> x = 0
=> 0
>> x = x + 1
=> 1
```

Updating a variable by adding 1 is called an **increment**;
subtracting 1 is called a **decrement**.

## The while statement

Computers are often used to automate repetitive tasks. Repeating
identical or similar tasks without making errors is something that
computers do well and people do poorly. In a computer program,
repetition is also called **iteration**.

We have already seen two methods, `countdown` and `print_n`,
that iterate using recursion. Because iteration is so common, Ruby
provides language features to make it easier. One is the
`for` statement we saw in
Section [repetition](./case_study_interface_design.md#simple-repetition).
We’ll get back to that later.

Another is the `while` statement. Here is a version of `
countdown` that uses a `while` statement:

```ruby
def countdown(n)
  while n > 0
    puts n
    n = n - 1
  end
  puts 'Blastoff!'
end
```

You can almost read the `while` statement as if it were
English. It means, “While `n` is greater than 0, display the
value of `n` and then decrement `n`. When you get
to 0, display the word `Blastoff!`”

More formally, here is the flow of execution for a `while`
statement:

1.  Determine whether the condition is true or false.

2.  If false, exit the `while` statement and continue
    execution at the next statement.

3.  If the condition is true, run the body and then go back to step 1.

This type of flow is called a loop because the third step loops back
around to the top.

The body of the loop should change the value of one or more variables so
that the condition becomes false eventually and the loop terminates.
Otherwise the loop will repeat forever, which is called an
**infinite loop**. An endless source of amusement for
computer scientists is the observation that the directions on shampoo,
“Lather, rinse, repeat”, are an infinite loop.

In the case of `countdown`, we can prove that the loop
terminates: if `n` is zero or negative, the loop never runs.
Otherwise, `n` gets smaller each time through the loop, so
eventually we have to get to 0.

For some other loops, it is not so easy to tell. For example:

```ruby
def sequence(n)
  while n != 1
    puts n
    if n % 2 == 0        # n is even
      n = n / 2
    else                 # n is odd
      n = n*3 + 1
    end
  end
end
```

The condition for this loop is `n != 1`, so the loop will
continue until `n` is `1`, which makes the
condition false.

Each time through the loop, the program outputs the value of
`n` and then checks whether it is even or odd. If it is even,
`n` is divided by 2. If it is odd, the value of
`n` is replaced with `n*3 + 1`. For example, if
the argument passed to `sequence` is 3, the resulting values
of `n` are 3, 10, 5, 16, 8, 4, 2, 1.

Since `n` sometimes increases and sometimes decreases, there
is no obvious proof that `n` will ever reach 1, or that the
program terminates. For some particular values of `n`, we can
prove termination. For example, if the starting value is a power of two,
`n` will be even every time through the loop until it reaches 1.
The previous example ends with such a sequence, starting with 16.

The hard question is whether we can prove that this program terminates
for *all* positive values of `n`. So far, no one
has been able to prove it *or* disprove it! (See
https://en.wikipedia.org/wiki/Collatz_conjecture.)

As an exercise, rewrite the method `print_n` from
Section [recursion](./conditionals_and_recursion.md#recursion) using
iteration instead of recursion.

## break

Sometimes you don’t know it’s time to end a loop until you get half way
through the body. In that case you can use the `break`
statement to jump out of the loop.

For example, suppose you want to take input from the user until they
type `done`. You could write:

```ruby
while true
  print '> '
  line = gets.chomp
  if line == 'done'
      break
  end
  puts line
end

puts 'Done!'
```

The loop condition is `true`, which is always true, so the
loop runs until it hits the break statement.

Each time through, it prompts the user with an angle bracket.
`print` is used here to have the prompt on same line as user
input. If the user types `done`, the `break`
statement exits the loop. Otherwise the program echoes whatever the user
types and goes back to the top of the loop. Here’s a sample run:

```
> not done
not done
> done
Done!
```

This way of writing `while` loops is common because you can
check the condition anywhere in the loop (not just at the top) and you
can express the stop condition affirmatively (“stop when this happens”)
rather than negatively (“keep going until that happens”).

## Square roots

Loops are often used in programs that compute numerical results by
starting with an approximate answer and iteratively improving it.

For example, one way of computing square roots is Newton’s method.
Suppose that you want to know the square root of `a`. If you start
with almost any estimate, `x`, you can compute a better estimate with
the following formula `y = (x + a/x) / 2`.

For example, if `a` is 4 and `x` is 3:

```ruby
>> a = 4.0
=> 4.0
>> x = 3.0
=> 3.0
>> y = (x + a/x) / 2
=> 2.1666666666666665
```

The result is closer to the correct answer (`sqrt(4) = 2`). If we
repeat the process with the new estimate, it gets even closer:

```ruby
>> x = y
=> 2.1666666666666665
>> y = (x + a/x) / 2
=> 2.0064102564102564
```

After a few more updates, the estimate is almost exact:

```ruby
>> x = y
=> 2.0064102564102564
>> y = (x + a/x) / 2
=> 2.0000102400262145

>> x = y
=> 2.0000102400262145
>> y = (x + a/x) / 2
=> 2.0000000000262146
```

In general we don’t know ahead of time how many steps it takes to get to
the right answer, but we know when we get there because the estimate
stops changing:

```ruby
>> x = y
=> 2.0000000000262146
>> y = (x + a/x) / 2
=> 2.0

>> x = y
=> 2.0
>> y = (x + a/x) / 2
=> 2.0
```

When `y == x`, we can stop. Here is a loop that starts with
an initial estimate, `x`, and improves it until it stops
changing:

```ruby
while true
  puts x
  y = (x + a/x) / 2
  break if y == x
  x = y
end
```

For most values of `a` this works fine, but in general it is
dangerous to test `float` equality. Floating-point values are
only approximately right: most rational numbers, like `1/3`, and
irrational numbers, like `sqrt(2)`, can’t be represented exactly with
a `float`.

Rather than checking whether `x` and `y` are
exactly equal, it is safer to use the built-in method `abs` to compute
the absolute value, or magnitude, of the difference between them:

``` 
  break if (y-x).abs < epsilon
```

Where `epsilon` has a value like `0.0000001` that determines
how close is close enough.

## Algorithms

Newton’s method is an example of an **algorithm**: it is a
mechanical process for solving a category of problems (in this case,
computing square roots).

To understand what an algorithm is, it might help to start with
something that is not an algorithm. When you learned to multiply
single-digit numbers, you probably memorized the multiplication table.
In effect, you memorized 100 specific solutions. That kind of knowledge
is not algorithmic.

But if you were “lazy”, you might have learned a few tricks. For
example, to find the product of `n` and 9, you can write `n-1` as
the first digit and `10-n` as the second digit. This trick is a
general solution for multiplying any single-digit number by 9. That’s an
algorithm!

Similarly, the techniques you learned for addition with carrying,
subtraction with borrowing, and long division are all algorithms. One of
the characteristics of algorithms is that they do not require any
intelligence to carry out. They are mechanical processes where each step
follows from the last according to a simple set of rules.

Executing algorithms is boring, but designing them is interesting,
intellectually challenging, and a central part of computer science.

Some of the things that people do naturally, without difficulty or
conscious thought, are the hardest to express algorithmically.
Understanding natural language is a good example. We all do it, but so
far no one has been able to explain *how* we do it, at
least not in the form of an algorithm.

## Debugging

As you start writing bigger programs, you might find yourself spending
more time debugging. More code means more chances to make an error and
more places for bugs to hide.

One way to cut your debugging time is “debugging by bisection”. For
example, if there are 100 lines in your program and you check them one
at a time, it would take 100 steps.

Instead, try to break the problem in half. Look at the middle of the
program, or near it, for an intermediate value you can check. Add a
`puts` statement (or something else that has a verifiable
effect) and run the program.

If the mid-point check is incorrect, there must be a problem in the
first half of the program. If it is correct, the problem is in the
second half.

Every time you perform a check like this, you halve the number of lines
you have to search. After six steps (which is fewer than 100), you would
be down to one or two lines of code, at least in theory.

In practice it is not always clear what the “middle of the program” is
and not always possible to check it. It doesn’t make sense to count
lines and find the exact midpoint. Instead, think about places in the
program where there might be errors and places where it is easy to put a
check. Then choose a spot where you think the chances are about the same
that the bug is before or after the check.

## Glossary

  - **reassignment**:  
    Assigning a new value to a variable that already exists.

  - **update**:  
    An assignment where the new value of the variable depends on the
    old.

  - **initialization**:  
    An assignment that gives an initial value to a variable that will be
    updated.

  - **increment**:  
    An update that increases the value of a variable (often by one).

  - **decrement**:  
    An update that decreases the value of a variable.

  - **iteration**:  
    Repeated execution of a set of statements using either a recursive
    method call or a loop.

  - **infinite loop**:  
    A loop in which the terminating condition is never satisfied.

  - **algorithm**:  
    A general process for solving a category of problems.

## Exercises

**Exercise 1**  
Copy the loop from Section [Square roots](#square-roots) and encapsulate
it in a method called `mysqrt` that takes `a` as a parameter,
chooses a reasonable value of `x`, and returns an estimate of
the square root of `a`.

To test it, write a method named `test_square_root` that prints a table
like this:

```
a   mysqrt(a)     Math.sqrt(a)  diff
-   ---------     ------------  ----
1.0 1.0           1.0           0.0
2.0 1.41421356237 1.41421356237 2.22044604925e-16
3.0 1.73205080757 1.73205080757 0.0
4.0 2.0           2.0           0.0
5.0 2.2360679775  2.2360679775  0.0
6.0 2.44948974278 2.44948974278 0.0
7.0 2.64575131106 2.64575131106 0.0
8.0 2.82842712475 2.82842712475 4.4408920985e-16
9.0 3.0           3.0           0.0
```

The first column is a number, `a`; the second column is the square
root of `a` computed with `mysqrt`; the third column is the square
root computed by `Math.sqrt`; the fourth column is the
absolute value of the difference between the two estimates.

**Exercise 2**  
The built-in method `eval` takes a string and evaluates it
using the Ruby interpreter. For example:

```ruby
>> eval('1 + 2 * 3')
=> 7
>> eval('Math.sqrt(5)')
=> 2.23606797749979
>> eval('Math::PI.class')
=> Float
```

Write a method called `eval_loop` that iteratively prompts the user,
takes the resulting input and evaluates it using `eval`, and
prints the result.

It should continue until the user enters `'done'`, and then return the
value of the last expression it evaluated.

**Exercise 3**  
The mathematician Srinivasa Ramanujan found an infinite series that can
be used to generate a numerical approximation of `1 / π`:

![numerical approximation of 1/pi](./figs/appx_1_by_pi.png)  
*Figure 7.2: Estimating pi*

Write a method called `estimate_pi` that uses this formula to compute
and return an estimate of `π`. It should use a `while`
loop to compute terms of the summation until the last term is smaller
than `1e-15` (which is Ruby notation for `10` to the power of `-15`).
You can check the result by comparing it to `Math::PI`.

