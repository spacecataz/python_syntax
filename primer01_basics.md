---
jupyter:
  jupytext:
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.14.4
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

Python Variables, Sequences, Mappings, Objects and Pointers
===========================================================

Scalar Variable Types and Multiple Assignment
------------------------
We will jump in to Python the same way we do with other languages: learning how to assign and manipulate variables.  Here's our overly simplified Hello-World example:


```python
a   = 5      # Integers
B   = 2.5    # Floating point reals
c10 = 3 + 7j # Complex numbers, 'j' sets the imaginary part.
d_1 = False  # Boolean values
print(a)
print(B)
print(c10)
print(d_1)
print( a * c10 )
```

This bit of code illustrates several concepts:

* There are four basic variable types: ints, floats, complex, and bools.
* The usual rules apply for variable naming: Must start with a letter; underscores and numbers allowed.
* Python is **case sensitive**.  "B" is a declared variable, "b" is not!
* Note that boolean True and False must capitalized.
* We see our happy print statement acting as expected.  Hello, world!
* In Python 3, mixed-mode arithmatic uses the highest precision variable type in the result.  **This was not true in Python 2.x!!**

There are functions that allow us to change variable types (e.g., *int()* and *real()*).
Let's define our values again, but differently.



```python
a, b, c = 1, 2, 3  # this is MULTIPLE ASSIGNMENT!
print(a)
print(c)
var1 = var2 = var3 = 10  # This is also multiple assignment!
print(var1)
print(var3)
```

    1
    3
    10
    10


This bit of code demonstrates a critical concept in Python: **Multiple Assignment**.  It seems trivial: we can define more than one variable in one line.  However, as you will see once we begin to work with loops and functions, it is an important concept to see how things operate in Python.  It's also very convenient.

Sequences
---------
Let's continue with somewhat more complicated data types: sequences.  Sequences are anything that can be indexed in a set order.  Our first sequence type is... a string!


```python
a='Ferrets are friends.'
print('Our string is "%s"' % a) # Old, c-like format codes.
print('Anoter way is to write "{}"'.format(a))  # New, Python3-like format codes.
```

Here, we declare a string and store it using the variable name "a".  Then, we print it to screen with some extra text attached.  We use C-like "%" syntax to substitute variables into string literals.
**NOTE**: This behavior has changed in Python 3 and is forward-compatible in Python 2.7.  Users should use the new formatting syntax, [summarized here](http://docs.python.org/2/library/string.html#formatstrings).  The old methods are [summarized here](http://mkaz.com/solog/python/python-string-format.html), mid-page, amongst other places.
In the final line, we use the new Python3-like syntax.  That will be our standard moving forward.

Sequences can be **indexed** and **sliced**.  Python indexing is useful if unsurprising:


```python
print(a[3])     # Index a single character.
print(a[0:2])   # Slice a range (zero based, up to the last number!)
print(a[0:10:2])# Use a third number to skip-count.
print(a[-1])    # Negative indexing is useful!
print(a[::-1])  # Backwards.
```

You can add strings and multiply them by integers.


```python
print(a + '\tSnakes, not so much.')  # Note the usual escape character syntax.
print(5*(a+'\t'))
```

We can check if something is _in_ a sequence.  Testing for **in** is very useful.


```python
print('Ferrets' in a)
print('Dogs' in a)
```

Lists and Tuples are sequences just like strings, but each item can be ANYTHING.  The only difference between lists and tuples is that tuples use regular parentheses and are _immutable_, that is, they cannot be changed in place.


```python
l1 = [1, 2, 3, 4] # A list of numbers.
print(l1[0::2])
```

```python
l2 = ['a', 'list', 'of', 'string', 'sequences']
print(l2)
```

Lists and tuples need not be homogenous.  Because each list item can be anything, you can nest lists inside lists.  To access an element within a list nested within a list, just use compound referencing:


```python
l3 = ['a list of', 'different things', 120, ['a', 'nested', 'sublist'], 12412.124]
# Get to nested objects using a chain of proper syntax!
print(l3[3][1])
```

Note how this works: `l3` is a list; `l3[3]` is the 3rd item (0-based indexing, so 4th overall!), which is a list itself; the first item of the list within `l3[3]` is therefore `l3[3][1]`.  Leverage this nesting capability to build complicated but easy-to-navigate data structures.

To demonstrate a previous point, watch what happens when we try to change a tuple:


```python
t1 = ('Tuples', 'are', 'similar')
t1[2] = ('but', 'cannot', 'be', 'changed')
```


```python
a[3]='B'
```


```python
listA = [1,2,3,4,5]; listB = listA # Use semicolons to delimit separate commands on a single line.
print(listA, listB)
listA[-1] = 10
print(listA, listB)
```

Whoa.  We changed $a$, but both $a$ and $b$ are changed.  This is because **everything in Python is a pointer**.  This is important to keep in mind when writing programs.  Additionally, it means that Python passes everything by reference and not by value.

There are several built in functions to work with sequences:


```python
print(len(a))     # len gives length.
print(min(l1))    # Min and max exist for lists of numbers.
print(list(a))    # There are many conversion functions, too, like "int" and "bool"
```

But the real power to work with sequences lies not in Built In Functions (BIFs) but _object methods_.
Python Objects
--------------
In python, **EVERYTHING IS AN OBJECT**.  That means that everything has _object attributes_ and _object methods_.  We access those using dot syntax.  Methods are just functions specific to that object while attributes are just values specific to that object.  To demonstrate, let's make a numpy array object, which is very similar to a list but has special attributes and methods.  Note that Numpy is an external package that may require installation.  [More information on Numpy can be found here.](http://www.numpy.org/)


```python
import numpy
b=numpy.arange(5)
print(b)       # This is what "b" looks like.
print(b.shape) # This attribute tells us that "b" is 1D.
print(b.mean())# This method gives us the mean of all values within "b".
print(b.mean)  # Printing without the parentheses tells us it's a method.
```

By exploring object methods, we see that our sequences do a lot of really cool stuff.  Even better, the **help()** function (IPython's _?_ operator) and IPython's tab-complete allow for on-the-fly object exploration.


```python
help(a.upper)
print(a.upper())
```

```python
help(l1.pop)
print(l1)
l1.pop(0)
print(l1)
```

```python
d1 = {'Dan':'Super person', 'Aaron':'Okay in small doses'}
# Curly braces denote dictionaries, colons separate keys and values, comma separates pairs.
print(d1)
# Access a single value by key (note how we accessed our nested method):
print("{0} sure is a {1}.".format('Dan', d1['Dan'].lower()))
# Change a value by key:
d1['Aaron'] = 'Better over time.'
# Add new values easily:
d1['Mike'] = 'Less vulgar than Aaron but more beardy.'
print(d1)
```

Per the usual, dictionaries have really cool methods.  They also sometimes work like sequences.


```python
print(d1.keys())          # Print all keys in dictionary "d1".
print(d1.values())        # Print all values in "d1".
print('Bryan' in d1)      # Does "d1" have the key "Bryan"?
```

A dictionary value can be any object.  Because everything is an object in Python, you can put functions, lists, objects, modules, ANYTHING into a dictionary.


```python
d2={'a':a, 'l2':l2, 'len':len}  # Store two lists and a function in a dictionary.
print(d2['len'](d2['l2']))       # Use the function inside the dictionary to act on a list.
```

What we did here was execute the function __len__, stored in dictionary _d2_ under key _'len'_, by handing it list _l2_ stored in _d2_ under key _'l2'_.  Note how we use the syntax: we used parentheses to treat the syntax _d2['len']_ as if we had called __len__ explicitly.  This natural way to store and access objects in complicated structures is one of Python's strengths.

