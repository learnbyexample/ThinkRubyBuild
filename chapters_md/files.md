# Files

This chapter introduces the idea of “persistent” programs that keep data
in permanent storage, and shows how to use different kinds of permanent
storage, like files and databases.

## Persistence

Most of the programs we have seen so far are transient in the sense that
they run for a short time and produce some output, but when they end,
their data disappears. If you run the program again, it starts with a
clean slate.

Other programs are **persistent**: they run for a long time
(or all the time); they keep at least some of their data in permanent
storage (a hard drive, for example); and if they shut down and restart,
they pick up where they left off.

Examples of persistent programs are operating systems, which run pretty
much whenever a computer is on, and web servers, which run all the time,
waiting for requests to come in on the network.

One of the simplest ways for programs to maintain their data is by
reading and writing text files. We have already seen programs that read
text files; in this chapter we will see programs that write them.

An alternative is to store the state of the program in a database. In
this chapter I will present a simple database and a module,
`Marshal`, that makes it easy to store program data.

## Reading and writing

A text file is a sequence of characters stored on a permanent medium like a
hard drive, flash memory, or CD-ROM. We saw how to open and read a file in
Section [Reading word lists](./case_study_word_play.md#Reading-word-lists).

To write a file, you have to open it with mode `'w'` as a second
parameter:

```ruby
>> fout = File.open('output.txt', 'w')
=> #<File:output.txt>
```

If the file already exists, opening it in write mode clears out the old
data and starts fresh, so be careful! If the file doesn’t exist, a new
one is created.

`File.open` returns a File object that provides methods for
working with the file. The `write` method puts data into the file.

```ruby
>> line1 = "This here's the wattle,\n"
=> "This here's the wattle,\n"
>> fout.write(line1)
=> 24
```

The return value is the number of characters that were written. The file
object keeps track of where it is, so if you call `write`
again, it adds the new data to the end of the file.

```ruby
>> line2 = "the emblem of our land.\n"
=> "the emblem of our land.\n"
>> fout.write(line2)
=> 24
```

When you are done writing, you should close the file.

```ruby
>> fout.close
=> nil
```

If you don’t close the file, it gets closed for you when the program
ends.

## Format operator

The arguments of `write` has to be a string, otherwise they
are converted to string using `to_s` method.

```ruby
>> x = 52
=> 52
>> x.to_s
=> "52"
```

An alternative is to use the **format operator**, `%`. When applied to
integers, `%` is the modulus operator. But when the first operand is
a string, `%` is the format operator.

The first operand is the **format string**, which contains
one or more **format sequences**, which specify how the
second operand is formatted. The result is a string.

For example, the format sequence `'%d'` means that the second operand
should be formatted as a decimal integer:

```ruby
>> camels = 42
=> 42
>> '%d' % camels
=> "42"
```

The result is the string `'42'`, which is not to be confused with the
integer value `42`.

A format sequence can appear anywhere in the string, so you can embed a
value in a sentence:

```ruby
>> 'I have spotted %d camels.' % camels
=> "I have spotted 42 camels."
```

If there is more than one format sequence in the string, the second
argument has to be an array for positional arguments or hash for named
arguments. For array, each format sequence is matched with an element,
in order.

The following example uses `'%d'` to format an integer, `'%f'` to format
a floating-point number, and `'%s'` to format a string:

```ruby
>> 'In %d years I have spotted %.2f %s.' % [3, 22.0 / 7, 'camels']
=> "In 3 years I have spotted 3.14 camels."
```

The number of elements in the array has to be at least the number of
format sequences in the string. Also, the types of the elements have to
match the format sequences:

```ruby
>> '%d' % [1, 2]
=> "1"

>> '%d %d %d' % [1, 2]
ArgumentError (too few arguments)

>> '%d' % 'dollars'
ArgumentError (invalid value for Integer(): "dollars")
```

In the second example, there aren’t enough elements; in the third, the
element is the wrong type.

For more information on the format operator, see
https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-sprintf.

## Filenames and paths

Files are organized into **directories** (also called
“folders”). Every running program has a “current directory”, which is
the default directory for most operations. For example, when you open a
file for reading, Ruby looks for it in the current directory.

The `Dir` and `File` classes provide methods for
working with files and directories. `Dir.pwd` returns the
name of the current directory:

```ruby
>> cwd = Dir.pwd
=> "/home/dinsdale"
```

`pwd` method will give “path of current working directory”.
The result in this example is `/home/dinsdale`, which is the
home directory of a user named `dinsdale`.

A string like `'/home/dinsdale'` that identifies a file or directory is
called a **path**.

A simple filename, like `memo.txt` is also considered a path,
but it is a **relative path** because it relates to the
current directory. If the current directory is
`/home/dinsdale`, the filename `memo.txt` would
refer to `/home/dinsdale/memo.txt`.

A path that begins with `/` does not depend on the current
directory; it is called an **absolute path**. To find the
absolute path to a file, you can use `File.absolute_path`:

```ruby
>> File.absolute_path('memo.txt')
=> "/home/dinsdale/memo.txt"
```

`File.exist?` checks whether a file or directory exists:

```ruby
>> File.exist?('memo.txt')
=> true
```

If it exists, `Dir.exist?` checks whether it’s a directory:

```ruby
>> Dir.exist?('memo.txt')
=> false
>> Dir.exist?('/home/dinsdale')
=> true
```

Similarly, `File.file?` checks whether it’s a file.

`Dir.children` returns a list of the files (and other
directories) in the given directory:

```ruby
>> Dir.children(cwd)
=> ["music", "photos", "memo.txt"]
```

To demonstrate these methods, the following example “walks” through a
directory, prints the names of all the files, and calls itself
recursively on all the directories.

```ruby
def walk(dirname)
  Dir.each_child(dirname) do |name|
    path = File.join(dirname, name)
    if File.file?(path)
      puts path
    else
      walk(path)
    end
  end
end
```

`Dir.each_child` helps to iterate over list of files and
directories in the given directory. `File.join` takes list of
strings and joins them into a path using `/` as separator.

The `Dir.glob` method works similar to this one but more
versatile. As an exercise, read the documentation and use it to print
the names of the files in a given directory and its subdirectories.

## Catching exceptions

A lot of things can go wrong when you try to read and write files. If
you try to open a file that doesn’t exist, you get an exception:

```ruby
>> fin = File.open('bad_file')
Errno::ENOENT (No such file or directory @ rb_sysopen - bad_file)
```

Here `Errno::ENOENT` is the name of the exception. If you don’t have
permission to access a file:

```ruby
>> fout = File.open('/etc/passwd', 'w')
Errno::EACCES (Permission denied @ rb_sysopen - /etc/passwd)
```

And if you try to open a directory for reading, you get

```ruby
>> fin = File.open('/home')
=> #<File:/home>
>> fin.readline
Errno::EISDIR (Is a directory @ io_fillbuf - fd:7 /home)
```

To avoid these errors, you could use methods like
`File.exist?` and `File.file?`, but it would take
a lot of time and code to check all the possibilities (if
“`Errno`” is any indication, there are many things that can
go wrong).

It is better to go ahead—and deal with problems if they happen—which is
exactly what the `rescue` clause does inside a `begin...end` block.
The syntax is similar to an `if...else` statement:

```ruby
begin
  fin = File.open('bad_file')
rescue
  puts 'Something went wrong.'
end
```

Ruby starts by executing the `begin` clause. If all goes well, it skips
the `rescue` clause and proceeds. If an exception occurs, it jumps out
of the `begin` clause and runs the `rescue` clause.

Handling an exception with a `begin` statement is called **catching**
an exception. In the above example, the `rescue` clause prints an
error message that is not very helpful.

```ruby
rescue => e
  puts e
  puts e.inspect
```

By assigning the exception object to a variable, you can deal with the
issue better, for example displaying the error message:

```
No such file or directory @ rb_sysopen - bad_file
#<Errno::ENOENT: No such file or directory @ rb_sysopen - bad_file>
```

`rescue` also accepts list of exceptions to specifically
rescue only those exceptions. In general, catching an exception gives
you a chance to fix the problem, or try again, or at least end the
program gracefully.

## Databases

A **database** is a file that is organized for storing
data. Many databases are organized like a hash in the sense that they
map from keys to values. The biggest difference between a database and a
hash is that the database is on disk (or other permanent storage), so it
persists after the program ends.

The `DBM` class provides an interface for creating and
updating database files. As an example, I’ll create a database that
contains captions for image files.

Opening a database is similar to opening other files:

```ruby
require 'dbm'
db = DBM.open('captions', 0666, DBM::WRCREAT)
```

The mode `0666` is octal file permission value, same notation as the
`chmod` unix command. The flag `DBM::WRCREAT` means that the
database should be created if it doesn’t already exist. The result is a
database object that can be used (for most operations) like a hash.

When you create a new item, `DBM` updates the database file.

```ruby
>> db['cleese.png'] = 'Photo of John Cleese.'
"Photo of John Cleese."
```

When you access one of the items, `DBM` reads the file:

```ruby
>> db['cleese.png']
"Photo of John Cleese."
```

If you make another assignment to an existing key, `DBM`
replaces the old value:

```ruby
>> db['cleese.png'] = 'Photo of John Cleese doing a silly walk.'
"Photo of John Cleese doing a silly walk."
```

Similar to hash, use `each` method to iterate over key-value
pairs:

```ruby
db.each { |k, v| puts "#{k} #{v}" }
```

As with other files, you should close the database when you are done:

```ruby
db.close
```

It is a good idea to read the documentation
https://ruby-doc.org/stdlib-2.5.0/libdoc/dbm/rdoc/DBM.html to know
about the caveats of using `DBM`.

## Marshaling

A limitation of `dbm` is that the keys and values have to be
strings. If you try to use any other type, they get converted to string
during assignment and you can specify only string keys while retrieving.

The `Marshal` module can help. It translates almost any type
of object into a string suitable for storage in a database, and then
translates strings back into objects.

`Marshal.dump` takes an object as a parameter and returns a
string representation (`dump` is short for “dump string”):

```ruby
>> t = [1, 2, 3]
=> [1, 2, 3]
>> Marshal.dump(t)
=> "\x04\b[\bi\x06i\ai\b"
```

The format isn’t obvious to human readers; it is meant to be easy for
`Marshal` to interpret. `Marshal.load` (“load
string”) reconstitutes the object:

```ruby
>> t1 = [1, 2, 3]
=> [1, 2, 3]
>> s = Marshal.dump(t1)
=> "\x04\b[\bi\x06i\ai\b"
>> t2 = Marshal.load(s)
=> [1, 2, 3]
```

Although the new object has the same value as the old, it is not (in
general) the same object:

```ruby
>> t1 == t2
=> true
>> t1.equal?(t2)
=> false
```

In other words, marshaling and then unmarshaling has the same effect as
copying the object.

As with `DBM`, read the documentation for caveats -
https://ruby-doc.org/core-2.5.0/Marshal.html

## Pipes

Most operating systems provide a command-line interface, also known as a
**shell**. Shells usually provide commands to navigate the
file system and launch applications. For example, in Unix you can change
directories with `cd`, display the contents of a directory
with `ls`, and launch a web browser by typing (for example) `firefox`.

Any program that you can launch from the shell can also be launched from
Ruby using a **pipe object**, which represents a running program.

For example, the Unix command `ls -l` normally displays the
contents of the current directory in long format. You can launch
`ls` with `IO.popen` (`File` is a subclass of `IO` class):

```ruby
cmd = 'ls -l'
fp = IO.popen(cmd)
```

The argument is a string that contains a shell command. The return value
is an object that behaves like an open file. You can read the output
from the `ls` process one line at a time with `readline` or get the
whole thing at once with `read`:

```ruby
res = fp.read
```

When you are done, you close the pipe like a file:

```ruby
>> stat = fp.close
=> nil
```

`nil` means that it ended normally (with no errors). The exit
status of the process can be obtained from global variable `$?`

For example, most Unix systems provide a command called
`md5sum` that reads the contents of a file and computes a
“checksum”. You can read about MD5 at
https://en.wikipedia.org/wiki/Md5. This command provides an efficient
way to check whether two files have the same contents. The probability
that different contents yield the same checksum is very small (that is,
unlikely to happen before the universe collapses).

You can use a pipe to run `md5sum` from Ruby and get the result:

```ruby
>> filename = 'words.txt'
=> "words.txt"
>> cmd = 'md5sum ' + filename
=> "md5sum words.txt"
>> fp = IO.popen(cmd)
=> #<IO:fd 7>
>> res = fp.read
=> "e58eb7b851c2e78770b20c715d8f8d7b  words.txt\n"
>> stat = fp.close
=> nil
```

## Writing modules

Any file that contains Ruby code can be inserted inside another script
using `require` statement. For example, suppose you have a
file named `wc.rb` with the following code:

```ruby
def linecount(filename)
  count = 0
  File.foreach(filename) { count += 1 }
  return count
end

puts linecount('wc.rb')
```

If you run this script, it reads itself and prints the number of lines
in the file, which is 7. You can also use it in another script by
specifying its file path like this:

```ruby
>> require './wc'
7
=> true
>> linecount('wc.rb')
7
```

The only problem with this example is that when you load the script it
runs the test code at the bottom.

In such cases, you will often see the following idiom:

```ruby
if __FILE__ == $0
  puts linecount('wc.rb')
end
```

`__FILE__` is a built-in keyword that contains name of current file.
`$0` is a global variable that contains name of script being executed.
So, if these two match, it means the file is being used as executable
and not loaded as a library in another script.

As an exercise, type this example into a file named `wc.rb`
and run it as a script. Then run the Ruby interpreter and use
`require` statement. What is the value of `$0`?

To write a collection of methods like the `Math` module,
enclose the methods inside `module` statement:

```ruby
module Wc
  def self.linecount(filename)
    count = 0
    File.foreach(filename) { count += 1 }
    return count
  end
end
```

The module name has to start with an uppercase alphabet. Also note that
the method name is prefixed with `self.` which we’ll cover in chapters
dealing with classes.

```ruby
>> require './wc_module'
=> true
>> Wc.linecount('wc_module.rb')
=> 7
```

## Debugging

When you are reading and writing files, you might run into problems with
whitespace. These errors can be hard to debug because spaces, tabs and
newlines are normally invisible:

```ruby
>> s = "1 2\t 3\n 4"
=> "1 2\t 3\n 4"
>> puts s
1 2  3
 4
```

The `inspect` method can help, we’ve already seen a few
examples before. It returns a string representation of the object. For
strings, it represents whitespace characters with backslash sequences:

```ruby
>> puts s.inspect
"1 2\t 3\n 4"
```

This can be helpful for debugging.

One other problem you might run into is that different systems use
different characters to indicate the end of a line. Some systems use a
newline, represented `\n`. Others use a return character, represented
`\r`. Some use both. If you move files between different systems, these
inconsistencies can cause problems.

For most systems, there are applications to convert from one format to
another. You can find them (and read more about this issue) at
https://en.wikipedia.org/wiki/Newline. Or, of course, you could write
one yourself.

## Glossary

  - **persistent**:  
    Pertaining to a program that runs indefinitely and keeps at least
    some of its data in permanent storage.

  - **format operator**:  
    An operator, `%`, that takes a format string and an array
    or hash and generates a string that includes the elements formatted
    as specified by the format string.

  - **format string**:  
    A string, used with the format operator, that contains format
    sequences.

  - **format sequence**:  
    A sequence of characters in a format string, like `%d`,
    that specifies how a value should be formatted.

  - **text file**:  
    A sequence of characters stored in permanent storage like a hard
    drive.

  - **directory**:  
    A named collection of files, also called a folder.

  - **path**:  
    A string that identifies a file.

  - **relative path**:  
    A path that starts from the current directory.

  - **absolute path**:  
    A path that starts from the topmost directory in the file system.

  - **catch**:  
    To prevent an exception from terminating a program using the
    `begin` and `rescue` statements.

  - **database**:  
    A file whose contents are organized like a hash with keys that
    correspond to values.

  - **shell**:  
    A program that allows users to type commands and then executes them
    by starting other programs.

  - **pipe object**:  
    An object that represents a running program, allowing a Ruby program
    to run commands and read the results.

## Exercises

**Exercise 1**  
Write a method called `sed` that takes as arguments a pattern
string, a replacement string, and two filenames; it should read the
first file and write the contents into the second file (creating it if
necessary). If the pattern string appears anywhere in the file, it
should be replaced with the replacement string.

If an error occurs while opening, reading, writing or closing files,
your program should catch the exception, print an error message, and
exit.

**Exercise 2**  
In a large collection of MP3 files, there may be more than one copy of
the same song, stored in different directories or with different file
names. The goal of this exercise is to search for duplicates.

1.  Write a program that searches a directory and all of its
    subdirectories, recursively, and returns an array of complete paths
    for all files with a given suffix (like `.mp3`). Hint:
    `Dir` and `File` classes provide several
    useful methods for manipulating file and path names.

2.  To recognize duplicates, you can use `md5sum` to compute
    a “checksum” for each files. If two files have the same checksum,
    they probably have the same contents.

3.  To double-check, you can use the Unix commands `diff` or
    `cmp`.

