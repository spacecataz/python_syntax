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
Python has several built-in tools for handling files, and some important tools that come with common packages.  
Let's cover the most important ones.

File Objects and Opening ASCII Files
-------------------

ASCII files are handled like everything else- with objects.  Specifically, _file_ objects.  These objects contain all you need to open, close, and write files.
The file used for this excercise is `player_rankings.txt`.  It is a list of players eligible for the 2011 draft sorted by their ranking (i.e., how draft pundits rated the players).  Information such as position and school are also included.
The file should be found in the `data` folder of this repository.

To start, we will create a file object using the built-in `open` function. The resulting file object will have important
attributes and methods that help us learn more about the file and read it, either line-by-line or all at once:

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

Above, we first opened the file and created a file object, `f`.  The file name is given as a string (literal or variable.)
If the file is not in the same directory as the working directory of your Python script (or Jupyter notebook), you'll need
to include the *absolute* or *relative* path - here, we included the relative path: `data/player_rankings.txt`.
We opened the file in read mode via the *'r'* argument.  It's also possible to open in *append mode* (*'a'*),
*write mode* (*'w'*), and various combinations (e.g. *'r+'* for combined read-write.)
There are several object attributes that we can use to remind us of the details of the file, e.g., `.mode` and `.name`.

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
# Create a file object that opens and interfaces to our file:
f = open('data/player_rankings.txt' ,'r')

# Read each line of the file, search for "QB" in the line:
for line in f:
    if "QB" in line:
        # Found a QB? Print that line to screen
        print(line.strip())
        
# Close the file when we're done.
f.close()
```

Cam Newton ranked 29th overall?  Preposterous!


## Handling Files with the `with` Statement

In the above example, let's suppose that our program crashed between opening and closing the file.
In the deep inner workings of Python, we would have an orphaned file object, lingering eternally
until `.close()` is called. If we're developing code, and we keep running-and-crashing-and running,
we could acrue many such orphaned objects, creating a [memory leak](https://en.wikipedia.org/wiki/Memory_leak). Such a situation is bad news, especially for production-quality codes.

Fortunately, Python gives us a tool to handle this: the `with` statement. 
These statements take the general form of:

```
with expression as target_var:
    do_something(target_var)
```

When you use `with`, however, you're telling Python that if we leave the `with` code block for *any* reason,
including crashes, there are certain actions that *must* be performed. In the case of files, the file
is closed and memory associated with the file are cleaned up. 

Let's see this in action by rewriting our code in the previous block using `with` statements:

```python
# Open our file under a `with` block:
with open('data/player_rankings.txt' ,'r') as f:
    # Read each line of the file, search for "QB" in the line:
    for line in f:
        if "QB" in line:
            # Found a QB? Print that line to screen
            print(line.strip())
```

This actually makes our code just a bit shorter and just a bit easier to read because all of our file-related
actions take place within the `with` block.

### __Always use `with` statements to open files.__

`with` can be used for other _external resourcses_ as well, such as network resources.
For more information on the `with` statement, [check out this article.](https://realpython.com/python-with-statement/)


## Writing ASCII Files

Writing files is just as easy as opening them- well, almost. The first step is to open the file in write mode using `'w'` instead of `'r'` (write instead of read). Then, we take advantage of the `.print` object method for files opened in write mode.

In the following example, we re-open our `player_rankings.txt` file and again find all of our QBs. 
Rather than print them to screen, we append each line to a list to hold the strings. Then, we open 
a new file in write mode, and dump our QB strings to that file. 


```python
# Create an empty list to hold our QB-related text lines:
qbs = []

# Open the file and find QB lines as before:
with open('data/player_rankings.txt', 'r') as f1:
    for line in f1:
        if "QB" in line:
            qbs.append(line)
            
with open('test.txt', 'w') as f2:
    # Add an initial header line to the file:
    f2.write('Ranked players that are position {0}\n'.format('QB') )
    
    # Now print the rest of the lines:
    for line in qbs:
        f2.write(line)

```

Examine the new file, `test.txt`, to ensure that everything printed as expected, using the `more` command:

```python
%more test.txt
# IPython's "magic" commands let you perform command-line functions. 
### IMPORTANT NOTE: The "more" command sometimes fails in Jupyter Notebooks... try this in a regular terminal.
```

Note that when we use **print**, we often get a newline automatically.  However, the *write* method is very
explicit: if we don't add newlines, they won't show up.

A newline character in a string is added with backslash-n: `\n`. See what happens in this next example when
we have some print statements 

```python
# Look at the file created by this code:
with open('test2.txt', 'w') as f:
    # Write some lines *with* and *without* new lines:
    f.write('This line and')
    f.write(' this one will be combined...\n')
    f.write('But this one stands alone!\n')

```

```python
%more test2.txt
# IPython's "magic" commands let you perform command-line functions. 
### IMPORTANT NOTE: The "more" command sometimes fails in Jupyter Notebooks... try this in a regular terminal.
```

Per the usual, use interactive help and IPython's auto-complete to explore the other file object methods.

Binary files won't be covered here, but they're not that different.  Simply add `b`, for binary, to the open mode (e.g. `'rb'` to write to a binary file.)
Typically, however, the binary format you want to open is some specialized format that has a python package that will do the work for you.


Utilities for Parsing Files
-----

Hopefully, the above examples have demonstrated that the *mechanics* behind opening and writing files is not that difficult.
In the end, the goal of file input & output is to save the "state" of your work to open later or share with others. 
When writing files, this will require determining how to organize the data in the file and format it so that it is more easily read by others. 
When reading files, the challenge is taking a series of ASCII lines of text and turning into arrays of `float`s, `int`s, `datetime`s.
Parsing text into useful Python objects is where most of the work takes place.

I will not go into detail concerning strategies for file parsing here. However, I do want to introduce some built-in and external-library-based tools for handling common file types. This starts with Python "pickles", a tool that serves as a "save state" for your work. Then, we'll review Numpy's `genfromtxt` function, which is a fairly versatile tool for handling simple text data files.


## Python Pickles

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

That is some stuff.  We want to save this for a later python session.  
We'll use the **pickle** module to dump this stuff to a special binary file that can be loaded later.
Let's create a file, dump a pickle into it (don't say that aloud in public), and close it.
Note that our file is opened in *binary write* mode (`'wb'`) and we continue to use the `with` statement:

```python
# Import the pickle library:
import pickle

# Open a file in binary write mode.
with open('temp.pkl','wb') as f_out:
    pickle.dump(a, f_out)
```

That was easy.  Our data has been pickled!  Let's load our pickle (again, don't say these things with 
people around.)
Some critical notes here:

* You must open the output file in *binary* mode, hence the "wb" in the **open** command.
* In Python2.\*, there are two "pickle" modules: "Pickle" and "cPickle".  Always use "cPickle" in Python2.\*
* We used the file extension ".pkl" here.  It actually doesn't matter what you use, but I recommend using something that is recognizable in the future (i.e., ".pkl").

Let's take the step of opening our file and reloading our data:

```python
# Open a file in binary read mode.
with open('temp.pkl', 'rb') as f_in: 
    b = pickle.load(f_in)  # Load the pickle into a variable.

# Print the contents to see if it worked
print(b)
```

Huzzah!  Note that we can pickle many objects into a single file.  We then just call *load* once for
each saved object, each time assigning it to a new variable.

```python
# Create some dummy data for this example:
c=['a','b','c','d']
d=np.matrix('1 2; 3 4')

# Now save it to a new file:
with open('temp2.pkl', 'wb') as f_out:
    pickle.dump(c, f_out)  # dump the first object...
    pickle.dump(d, f_out)  # ...then the second object.

##### Pretend this is a new session at a later date ####
# Open the pickle file and load the objects:
with open('temp2.pkl', 'rb') as f_in:
    e=pickle.load(f_in)  # Load the first object...
    g=pickle.load(f_in)  # ...then the second.

# Print both to screen:
print("This is the first pickled object:", e)
print("This is the second pickled object:", g)
```

Note that if we try to load another pickled object from our file, an *EOFError* (end-of-file error) exception is thrown, causing our program to crash.  It's good to know how many pickles are in each file.  Alternatively, it is possible to just save the items grouped together via a *tuple* or *list*. That way, you only need to save and load a single object.

```python
# Create some dummy data
with open('temp3.pkl', 'wb') as f_out:
    # Dump four objects grouped within a tuple
    pickle.dump( (a,b,c,d), f_out)

##### New Session ####
# Load the data with a single "load" call:
with open('temp3.pkl', 'rb') as f_in:
    w,x,y,z = pickle.load(f_in) # multiple assignment FTW!

# Use a loop and a fancy print statement to print each to screen
for i, obj in enumerate((w, x, y, z)):
    print('Loaded object #{}: {}'.format(i,obj))

```

If you are given a pickle file and don't know how many objects have been pickle-dumped into it, this snippet of code helps:

```python
with open('temp2.pkl', 'rb') as f_in:  # Open the file.
    data = []  # Create an empty list.
    while True:
        try:
            data.append(pickle.load(f_in))
        except EOFError:
            break

# Print resulting data to screen.
print(data)
```

A lot just happened there.  First we opened our file and created a new but empty list object.  Then, we start an infinite loop.  For each iteration of this
loop, we use the **try** statement to *attempt* to read a pickled object from that file.  If successful, the object is *appended* onto the list (the list
grows in size and the new object is put into the new list slot.)  If there are no more pickles to load in our file, the **try** statement fails, but the 
*IOError* exception doesn't cause our code to fail.  Rather, the exception is *caught*, and control is handed to the **except** clause, which tells the
**while** loop to break.  While this may not be the most efficient or elegant way to approach this problem, it exemplifies Python's exception handling
capabilities which we will explore later.


## Numpy's `genfromtxt`

The next tool to review is `genfromtxt`, part of the Numpy package. 
Most simple data files are organized such that each column represents a different variable and each row is one entry of the data series. Take, for example, the file `data/simple_data1.csv`:


```
Year,Month,Day,Hour,Min,Sec,dbn_nez,dbe_nez,dbz_nez,dbn_geo,dbe_geo,dbz_geo
2001,03,05,00,00,00,-61.0,21.0,-0.2,-60.6,22.0,-0.2
2001,03,05,00,01,00,-62.0,21.0,-0.1,-61.6,22.0,-0.1
2001,03,05,00,02,00,-63.0,21.0,-0.1,-62.7,22.0,-0.1
2001,03,05,00,03,00,-64.0,22.0,-0.1,-63.7,23.0,-0.1
2001,03,05,00,04,00,-66.0,22.0,-0.1,-65.7,23.0,-0.1
2001,03,05,00,05,00,-67.0,22.0,0.9,-66.7,23.1,0.9
```


This is a typical comma-separated-value (`*.csv`) file: each row is one entry in time of several variables, each separated by commas. We have a 1-line header that tells us what the values in each column represent (in this case, we have time values and real-world ground magnetometer data).

__`genfromtxt` will read this data and convert it into a set of Numpy objects (typically, an N-column by N-row array).__

I recommend reading (https://numpy.org/doc/stable/user/basics.io.genfromtxt.html)[the full documentation page for this function], but we'll cover the most important aspects here.
Let's loading this file using `genfromtxt` to see what happens:

```python
import numpy as np

# Open the file; the "delimiter" keyword tells us what character(s) separate variables:
data = np.genfromtxt('data/sample_data1.csv', delimiter=',')

# Print the returned data array and then print its shape:
print(data)
print(data.shape)
```

Not too bad! `genfromtxt` returned a 2-dimensional array of size N-Rows by N-Columns - or, more accurately, an array where one dimension is time and the other dimension is the variables. I can verify that the function worked by comparing the first and last rows in the returned array to the corresponding values in the `.csv` file. Looks good to me!

I can visualize the data in a straightforward manner:

```python
# Import matplotlib and turn on in-line plotting in Jupyter
import matplotlib.pyplot as plt
%matplotlib inline

# Make a quick plot:
plt.plot(data[:,6])
```

There are some issues here, however:

- The first line, which is the "header" with variable names, is converted to not-a-number (NaN) values.
- Our time values (year, month, etc.) is split over several columns instead of being date times.
- To get a certain data value, we have to count columns and then insert that number into `data[:,i]`.

Best case scenario: there are no NaNs, we have `datetime` time values, and we have dictionary-like functionality with variable names. Fortunately, `genfromtxt` can do all of that!

Let's start with the easy part- skipping the first line. You can set how many lines to skip upon reading a file:

```python
# Skip one header line
data = np.genfromtxt('data/sample_data1.csv', delimiter=',', skip_header=1)

# No more NaNs!
print(data)
```

That is a slight improvement, but we can do better. Instead of skipping the header, let's tell `genfromtxt` to use it as the variable names. When you do this, `genfromtxt` no longer returns an array, but rather a _data object_ that behaves like a dictionary.

```python
# Open data, but parse header as variable names
data = np.genfromtxt('data/sample_data1.csv', delimiter=',', names=True)

# Look at our data as a whole
print(data)

# Look at the dtype of our data object
print(data.dtype)

# We no longer have an array, but a data object
print(data['Hour'])
print(data['dbn_nez'])

# Make a better plot
plt.plot(data['Hour'] + data['Min']/60., data['dbn_nez'])
# Add axes labels
plt.xlabel('Hours')
plt.ylabel(r'$\Delta B_N$ ($nT$)')
```

Note that setting `names=True` tells `genfromtxt` to use the first line as column names. Alternatively, we could set the column names ourselves by handing the function a list or tuple of strings.

The above result is a huge improvement in terms of functionality and useability with very little effort on our behalf. Note that we still have some issues: We only have time in hours (and had to add hours and minutes to get a working X-axis!) **and** Numpy made everything a floating point number even though our dates/times should be integers. Solving these issues for the current file would require two steps:

- Use of the `dtype` keyword allows us to specify the variable type as a whole or per-column; if we set `dtype=None`, `genfromtxt` will detect the most appropriate datatype per variable.
- We could use the `datetime` module to turn hour year, month, day, etc. values into an array of `datetime.datetime` objects.

Instead, let's look at the same data in a slightly different format. This is the file `data/simple_data2.csv`:


```
Date_UTC,Extent,IAGA,GEOLON,GEOLAT,MAGON,MAGLAT,dbn_nez,dbe_nez,dbz_nez,dbn_geo,dbe_geo,dbz_geo
2001-03-05T00:00:00,60,BNG,18.57,4.33,90.24,-5.63,-61.0,21.0,-0.2,-60.6,22.0,-0.2
2001-03-05T00:01:00,60,BNG,18.57,4.33,90.24,-5.63,-62.0,21.0,-0.1,-61.6,22.0,-0.1
2001-03-05T00:02:00,60,BNG,18.57,4.33,90.24,-5.63,-63.0,21.0,-0.1,-62.7,22.0,-0.1
2001-03-05T00:03:00,60,BNG,18.57,4.33,90.24,-5.63,-64.0,22.0,-0.1,-63.7,23.0,-0.1
2001-03-05T00:04:00,60,BNG,18.57,4.33,90.24,-5.63,-66.0,22.0,-0.1,-65.7,23.0,-0.1
```


This file has far more information, mixes strings and numbers, and time is given as `YYYY-MM-DDTHH:MN:SS`. Reading this text file using `genfromtxt` does not go nearly as well...

```python
# Open data, but parse header as variable names.
data = np.genfromtxt('data/sample_data2.csv', delimiter=',', names=True)

# Look at our data as a whole
print(data)

# Look at the dtype of our data object
print(data.dtype)
```

`genfromtxt` tries to convert everything to a floating point number, and this causes all of our text data to get turned into NaNs. We're going to make two changes to fix this:

- Set `dtype=None` so that `genfromtxt` assigns datatype automatically by column.
- Set `encoding='utf-8'` to tell `genfromtxt` how to convert the file values into strings. 

This gives us much more favorable results:

```python
# Open data, but parse header as variable names.
# Note our two extra keywords: dtype and encoding.
data = np.genfromtxt('data/sample_data2.csv', delimiter=',', names=True, dtype=None, encoding='utf-8')

# Look at our data as a whole
print(data)

# Look at the dtype of our data object
print(data.dtype)
```

Our final step is to do *something* about those time values. We _could_ convert them into `datetime` objects directly (refer to the primer on `datetime` objects for details on the precise syntax). Here's how we would do it manually for one variable:

```python
import datetime

# A sample time entry from our file:
raw_time = '2001-03-05T23:57:00'

# The strptime function converts text into datetimes:
t = datetime.datetime.strptime(raw_time, '%Y-%m-%dT%H:%M:%S')
t
```

<!-- #region -->
We want to do _that_ for every time entry. Instead of doing it after opening the file, why not do it while `genfromtxt` is reading the file itself? That functionality comes via the `convert` keyword, that allows us to set a function to convert the file data into a python or numpy object. The function we want to use is, 

```python
datetime.datetime.strptime(raw_time, '%Y-%m-%dT%H:%M:%S')
```

Further, we want to apply this function *only* to the values in the first column. Let's tell `genfromtxt` to do exactly that.
We're going to use a `lambda` function definition to assign our preferred function to a variable, then pass that to the 
`convert` keyword. A dictionary is used to tell `genfromtxt` that this function should *only* be applied to the first column.
<!-- #endregion -->

```python
# Create a function and assign it to our variable, "tconvert"
tconvert = lambda x: datetime.datetime.strptime(str(x), '%Y-%m-%dT%H:%M:%S')

# Open data using several kwargs to customize how things are read
data = np.genfromtxt('data/sample_data2.csv', delimiter=',', names=True, dtype=None,
                     encoding='utf-8', converters={0:tconvert})

# Look at our newly converted time
print(data['Date_UTC'])

# Plot the data against datetimes!
plt.plot(data['Date_UTC'], data['dbn_nez'])
# Add axes labels
plt.xlabel('Time')
plt.ylabel(r'$\Delta B_N$ ($nT$)')
```

This is exactly what we want- all of our values are of the correct time; time values are `datetimes`, values are accessed by their name instead of position-in-file; and evertyhing is grouped into a single object. 

`genfromtxt` is seriously powerful and can be a huge time saver when opening text-based data files. I recommend reading the documentation to get a full idea of the range of keyword options available.

```python

```
