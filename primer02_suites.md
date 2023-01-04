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

Python Code Suites: Conditionals, Loops, and Functions
==================
Blocks of Python code are called *suites*; suites are delimited by tabs, not brackets or end statements.

IF Statements
-----------
As with all code suites, tabs mark what belongs to what suite.  Beyond tabs, no big surprises here.

```python
if True:
    print('A WINNAR IS YOU!')
if False:
    print('YOU FAILED IT.')
```

Note the use of reserved words **True** and **False** (case matters in Python!)  
Things that are also **True**:

+  Non-empty lists/tuples/dictionaries.
+  Non-null strings.
+  Declared objects, functions, etc.

It follows that these things are **False**:

+  Empty lists/tuples/dictionaries.
+  Null strings ('').
+  The **None** object.

```python
if 'A word':
    print('Non-null strings!')
if [1,2,3]:
    print('Lists with elements!')
if lambda x: x**2:
    print('Declared functions!')
```

```python
if '':
    print('Null strings!')
if []:
    print('Empty strings!')
if None:
    print('None objects!')
```

The usual relational operators apply.

+  == (equality)
+  != (inequality)
+  <, >, <=, >= (less than, etc.)
+  and, or

```python
if (3>1) and ('abcd'=='abcdefg'[0:4]):
    print('You betcha.')
```

Using tabs to delimit different suites makes code easy to read, even if you nest suites!

```python
if True:
    print('Some commands before!')
    print('Many of them.')
    if True:
        print('Inside a nested suite.')
        print('Continue nested suite.')
    print('This line is in the outer "if" statement.')
print('This command ends the outer suite.')
```

Finally, there's the extra conditionals.

```python
if False:
    print('Not this one.')
elif False:
    print('Nor this one.')
else:
    print('This one!')
```

Note the absence of a "case" or "switch" statement in Python.  Many options require many _if-elif-else_ conditionals (or, preferably, a more _pythonic_ approach to your code!)

One final thing: all code suites must have some code; you can't have empty suites.  If you need an empty suite (usually for a temporary placeholder), use the **pass** statement.

```python
# This suite does nothing.
if True:
    pass
```

WHILE Loops
-----------
Again, this is pretty standard.  The loop continues so long as the *while* conditional is met.  

```python
i=0
while i<5:
    print('Numba {0}'.format(i))
    i+=1
```

**break** leaves the current loop; **continue** jumps immediately to the next iteration.

```python
i=0
while i< 35:
    i+=1
    if i==2: continue  # If i==2, jump to the next iteration.
    if i==5: break     # If i==5, leave the loop outright.
    print(i)
```

An Interlude: Iterators
-----------------
A key to understanding Python **for** loops is the idea of iterators.  
First, life without iterators: Let's suppose we want to loop over each of the elements of this list. We could use a while loop to progress through each list index...
 

```python
a=['a','b','c','d','e']
i=0
while i<len(a):
    print(a[i])
    i+=1
```

Or, use an iterator.  Iterators have special object methods that return the next item in order from what was used to make the iterator.  You can turn any sequence into an iterator using the **iter()** generator function. Then, we can use the intrinsic function **next()** to get the next item in turn from the iterator, removing the onus of keeping track of the next entry in our loop:

```python
b=iter(a)
while True:
    print(next(b))
```

What did this buy us?  Not much.  We didn't need to keep track of our index integer, but when we ran out of things to iterate over, our program just crashed.  We need a way to catch the error and stop the loop (this is actually pretty easy, but not practical.  The beauty of Python **for** loops is that they generate an iterator, employ the **next** function internally, and stop when you're out of items.  It's that easy.

```python
for item in a:
    print('Our item is {}.'.format(item))
```

What makes this especially powerful is the Pythonic concept of multiple assignments.  

```python
dbl_list = [ [1,'a'], [2,'b'], [3, 'e'] ]
for a, b in dbl_list:
    print('#{0} is "{1}"'.format(a, b))
```

What happened here is that each item that our iterator returns is a single entry from our list, "dbl_list".  Each entry is a sublist with two sub-elements, so we assign each sub-element to its own variable in our **for** loop.  Our "dbl_list" is inconvenient, but there are a bunch of built-in functions that make **for** very, very powerful.  **enumerate()** returns a set of index-value pairs while **zip()** zips multiple sequences together by like-element pairs (or more).

```python
list1=['dog', 'cat', 'bobcat']
list2=['puppy','kitten', 'bobkitty']
list3=['bazooka','tank','lazer']

for i, a in enumerate(list1):
    print('Animal #{0} is {1}'.format(i, a))
    
for a, b, c in zip(list1, list2, list3):
    print(a, b, c)
```

A lot of things can be put into **for** loops to create magic:

```python
names = {'House':'Grumpy', 'Wilson':'Considerate'}
for n in names:
    print('{0} is {1}.'.format(n, names[n].lower()))
```

Here, we declared a dictionary.  Then, our **for** loop created an iterator out of the dictionary keys.

Finally, there are these amazing things called *list comprehensions*, where you can put a psuedo-**for** loop into a list and the magic happens.

```python
a = [x**2 for x in range(6)]
print(a)
```

This is amazing and should be used often.

Functions
---------
Functions are easy to declare and use in Python.  Let's declare one and dissect the pieces.

```python
def example(arg1, arg2, kwarg1='Default', kwarg2=None):
    '''Use docstrings every time!'''
    print('Our first required argument is ', arg1)
    print('Our first keyword argument is ', kwarg1)
    if kwarg2:
        print('Second keyword set!')
    return 1, 2, 'dog'
string = 'Remember, ending the tabbed environment closes suites.'
```

```python
help(example)
```

```python
a, b, c = example('ARG1', 'ARG2', kwarg2='ARG3')
```

```python
group = example('ARG1', 'ARG2', 'ARG3', 'ARG4')
print(group)
```

As you can see, you can declare any number of required arguments (*args*) and any number of keyword arguments (*kwargs*).  Regular args must be given and in the correct order.  Keyword arguments (*kwargs*) are optional and can either be listed in the correct number and order OR be given in any arbitrary order so long as the keyword is supplied.  Any number of values can be returned, and they can be assigned individually or as a grouped tuple.  ALWAYS, ALWAYS USE A DOCSTRING.  The block string after the declaration is your function's documentation!  Try typing "example?" in IPython!

Don't forget that functions are objects!  You can hand a function to a function as an argument, put them in lists and dictionaries, so on and so forth.

```python
def ex2(func):
    print('Func is ', func)
ex2(example)
```

Because functions are their own objects, you can set attributes and new methods.  This mechanism allows them to act as new name spaces.

```python
dog = 'woof'
ex2.dog='bark'
print(dog, ex2.dog) # The two variables do not overwrite because they are in different name spaces.
```

Lastly, functions can be defined *in line* using the **lambda** command.  Let's create a simple function, then see how **lambda** makes it faster to declare.

```python
def square(x):
    return x**2
sqr = lambda x: x**2
    
print(square(4))
print(sqr(4))
```

The **lambda** syntax is useful for quick function declarations, especially when you want to create a function directly in a list or dictionary.  They are also very nice for list comprehensions!

```python
funcs = [lambda x: x**2, lambda x: 2.*x**2+5, lambda x: 3./4. * x**0.5]
for f in funcs:
    print(f(25))
```
