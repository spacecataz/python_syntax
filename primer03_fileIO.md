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

Python I/O: Reading, Writing, Pickling
===============
Python has several built-in tools for handling files.  Let's cover the most important ones.
File Objects and ASCII
-------------------
ASCII files are handled like everything else- with objects.  Specifically, _file_ objects.  These objects contain all you need to open, close, and write files.
The file used for this excercise is "player_rankings.txt".  It is a list of players eligible for the 2011 draft sorted by their ranking (i.e., how draft pundits rated the players).  Information such as position and school are also included.  Make sure you have this file in your current working directory before running this notebook!

```python
# Create a file object
f = open('data/player_rankings.txt', 'r')
# Attributes tell us things about the file.
print(f.mode)
print(f.name)
# Methods perform the usual file actions.
a=f.readline()
print(a)
```

Per the usual, **help** or IPython's **?** operator combined with tab-complete will help you explore the object's methods easily.

Above, we first opened the file and created a file object, *f*.  The file name is given as a string (literal or variable.)
We opened the file in read mode via the *'r'* argument.  It's also possible to open in *append mode* (*'a'*),
*write mode* (*'w'*), and various combinations (e.g. *'r+'* for combined read-write.)

Next, we used the method *readline* to read a single line (until the invisible newline character is found) and move the file
pointer to the position just after the newline character.  Note that newline characters are platform 
dependent, but modern languages typically do the work for you.  This method returned the read line as a string.  
What if we wanted to read a bunch of lines at once?

```python
lines = f.readlines()
print(lines[0:3])
f.close()
```

Here, we see that the *readlines* method slurps the rest of the file from the current pointer location to the end.  Then, the contents are separated by newline character and put into a list.

Like good file stewards, we closed the file using *close*.  Python is very forgiving about leaving files open, but let's not take advantage of that good nature.

Note that file objects are iterators with a *next* method.  This means, similar to list objects, we can put them into a *for* loop with minimal work.
Let's loop through our file and find all of the players that are quarterbacks.

```python
f = open('player_rankings.txt' ,'r')
for line in f:
    if "QB" in line:
        print(line.strip())
f.close()
```

Cam Newton ranked 29th overall?  Preposterous!

Writing to files is just as easy:

```python
f1 = open('player_rankings.txt', 'r')
f2 = open('test.txt', 'w')
f2.write('Ranked players that are position {0}'.format('QB') )
for line in f1:
    if "QB" in line:
        f2.write(line)
f1.close()
f2.close()
```

Note that when we use **print**, we often get a newline automatically.  However, the *write* method is very
explicit: if we don't add newlines, they won't show up.

```python
# Look at the file created by this code:
f=open('test2.txt', 'w')
f.write('This line and')
f.write(' this one will be combined...\n')
f.write('But this one stands alone!\n')
f.close()
```

```python
%more test2.txt
# IPython's "magic" commands let you perform command-line functions. 
### IMPORTANT NOTE: The "more" command sometimes fails in Jupyter Notebooks... try this in a regular terminal.
```

Per the usual, use interactive help and IPython's auto-complete to explore the other file object methods.

Binary files won't be covered here, but they're not that different.  Simply add *b*, for binary, to the open mode (e.g. *'rb'* to write to a binary file.)
Typically, however, the binary format you want to open is some specialized format that has a python package that will do the work for you.
Pickles
-------
Often, it is nice to dump data to a file without worrying about the format, especially if you can write
objects to file and restore them in the exact same state.
Python has such a mechanism: *pickles*.  *Pickling* is the act of dumping objects directly to a special
binary format that can be in a later session.  Let's start by making a complicated object.

```python
import numpy as np  # import Numpy; more on importing soon.
a={1:np.zeros(20), 2:np.arange(0, np.pi, np.pi/16.0), 3:['hot','dogs']}
for key in a:
    print(a[key])
```

That is some stuff.  We want to save this for a later python session.  We could use the **pickle** module,
but we'll use **cpickle**, which is much, much faster but syntactically equivalent.  
Let's create a file, dump a pickle into it (don't say that aloud in public), and close it.

```python
import pickle
f_out=open('temp.pkl','wb')  # Open a file in binary write mode.
pickle.dump(a, f_out)
f_out.close()
```

That was easy.  Our data has been pickled!  Let's load our pickle (again, don't say these things with 
people around.)
Some critical notes here:

* You must open the output file in *binary* mode, hence the "wb" in the **open** command.
* In Python2.\*, there are two "pickle" modules: "Pickle" and "cPickle".  Always use "cPickle" in Python2.*
* We used the file extension ".pkl" here.  It actually doesn't matter what you use, but I recommend using something that is recognizable in the future (i.e., ".pkl").


```python
f_in = open('temp.pkl', 'rb') # Open a file in binary read mode.
b = pickle.load(f_in)       # Load the pickle into a variable.
print(b)
f_in.close()
```

Huzzah!  Note that we can pickle many objects into a single file.  We then just call *load* once for
each saved object, each time assigning it to a new variable.

```python
c=['a','b','c','d']
d=np.matrix('1 2; 3 4')
f_out=open('temp2.pkl', 'wb')
pickle.dump(c, f_out)
pickle.dump(d, f_out)
f_out.close()
##### New Session ####
f_in=open('temp2.pkl', 'rb')
e=pickle.load(f_in)
g=pickle.load(f_in)
f_in.close()
print(e, g)
```

Note that if we try to load another pickled object from our file, an *IOError* exception is thrown, causing our program to crash.  It's good to know how many pickles are in each file.  Alternatively, it is possible to just save the items as a *tuple* or *list*.

```python
f_out=open('temp3.pkl', 'wb')
pickle.dump( (a,b,c,d), f_out)
f_out.close()
##### New Session ####
f_in=open('temp3.pkl', 'rb')
w,x,y,z = pickle.load(f_in) # multiple assignment FTW!
f_in.close()
print(w,x,y,z)
```

If you are given a pickle file and don't know how many objects have been pickle-dumped into it, this snippet of code helps:

```python
f_in=open('temp2.pkl', 'rb')  # Open the file.
data = []  # Create an empty list.
while True:
    try:
        data.append(pickle.load(f_in))
    except:
        break
print(data)
```

A lot just happened there.  First we opened our file and created a new but empty list object.  Then, we start an infinite loop.  For each iteration of this
loop, we use the **try** statement to *attempt* to read a pickled object from that file.  If successful, the object is *appended* onto the list (the list
grows in size and the new object is put into the new list slot.)  If there are no more pickles to load in our file, the **try** statement fails, but the 
*IOError* exception doesn't cause our code to fail.  Rather, the exception is *caught*, and control is handed to the **except** clause, which tells the
**while** loop to break.  While this may not be the most efficient or elegant way to approach this problem, it exemplifies Python's exception handling
capabilities which we will explore later.
