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
    display_name: Python 3
    language: python
    name: python3
---

Scientific Python: Numpy
===============

Python was initially created to be a scripting language. As such, it lacked
fundamental tools for mathematics: true array and matrix-like objects,
linear algebra tools, etc.
With its popularity growth, especially in scientific communities, this
changed through the addition of external packages.
While there are many such packages today, including Scipy, Matplotlib, and 
Pandas, the most fundamental is **Numpy**.

Numpy introduces true *arrays*: multidimensional homogenous ordered data
containers (think *lists*, but N-dimensional and with uniform data types).
It also contains a wealth of tools related to arrays, from signal processing,
interpolation, and much more.
In this tutorial, we'll cover some basic syntax of this package.
Additionally, we'll start to play with Matplotlib- Python's most popular 2D
plotting software. Numpy and Matplotlib are tightly coupled in practice and
in development, so introducing some basic Matplotlib syntax at this level comes
natural.

Overall, this guide is a *minimal* introduction to Numpy. 
Please dig through the [Numpy documentation](https://numpy.org/doc/stable/user/index.html)
for more critical details on this package.

Users of Matlab (or other scientific-focused languages) will find most of the
behavior of Numpy quite familiar- indeed, [there is a guide on comparing the
two languages](https://numpy.org/doc/stable/user/numpy-for-matlab-users.html).

Finally, we should note that it's pronounced *Num-__Pie__*, that is, *Num*ber 
*Py*thon. It's not *__NUM__-pee*, as in *rhymes with lumpy*. 
That would be just silly.


## A Mathematical Obstacle

Let's suppose that you had a series of data points (e.g., temperature, 
in Celsius, at a certain location). It is time series data, one point per
minute. This is *serial*, it is ordered in time and that order matters.
The obvious choice to store such data would be a python `list` of `float`s:

```python
# Some sample data:
temp = [42.1, 42.5, 43.1, 42.9, 43.3, 43.9]
print(temp)
```

Now, let's convert that from Celsius to Farhenheit. 
The formula to do so is $F = C \times 1.8 + 32 $: we need to multiply each
item in `temp` by 32 then add 18. However, we are using a python list, so we
need to do this one element at a time (recall that if we multiply a list by an 
integer, we will get $n$ copies of the list; multiplication by a float raises 
an exception):

```python
for i in range(len(temp)):
    temp[i] = 1.8 * temp[i] + 32

print(temp)
```

Obviously, this is not a terribly efficient way to go about things. 
It gets worse- suppose we had two series of numbers, and we need to multiply them
together element-by-element. We'd need another loop.
Now, imagine the various tasks required in linear algebra- especially when
we change from 1-D vectors to N-D matrices. Loops! Loops within loops!
The tasks get complicated, inefficient (both in coding and computation time),
and prone to small syntactical mistakes. It's ugly.

Numpy solves this issue on multiple levels by introducing *arrays*: list-like
objects that fundamentally work on an element-by-element level.


## An Introduction to the Numpy Array


Let's recreate our temperature data using a Numpy *array* object:

```python
# Import our library- note that it is VERY common to
# relabel numpy as "np".
import numpy as np

# Generate an array from a list of literals:
temp = np.array([42.1, 42.5, 43.1, 42.9, 43.3, 43.9])

# Print to screen:
print(temp)

# Indexing works similarly to lists:
print(temp[0])    # first element
print(temp[-1])   # last element
print(temp[2:5])  # elements 2 up to but not incluing 5
print(temp[::2])  # skip count by 2
```

Our initial impression is that our "array" version of `temp` doesn't differ much from our list version. They seem to behave like lists, including indexing. 

However, things get more interesting when we start to do math:

```python
temp_f = 1.8 * temp + 32
print(temp_f)
```

Math occurs on an element-by-element basis, no loop necessary.

Let's see this behavior when we multiply two arrays together:

```python
widths = np.array([2.5, 3.5, 4.5])
heights = np.array([10, 20, 30])

areas = widths * heights

# Show the resulting array:
print(areas)

# Format-print the results:
for w, h, a in zip(widths, heights, areas):
    print(f"{w} x {h} = {a}m^2")
```

You can perform arithmetic with two Numpy arrays so long as they are the same shape and size. The math will be performed on an element-by-element basis.


Speaking of size, Numpy arrays can be multiple dimensions without nesting:

```python
# Two dimensional lists via nesting:
list_2d = [[1, 2, 3], [3, 4, 5]]
print(list_2d)
print(f"The item in the first row, last column is... {list_2d[0][2]}")

# How to reference a "2D" list- daisy-chain indexes together

# Two dimensional **arrays**:
array_2d = np.array([[1, 2, 3], [3, 4, 5]])
print(array_2d)
print(f"The item in the first row, last column is... {array_2d[0, 2]}")

# Each dimension can take an index triple of start:stop:step:
print(array_2d[:, ::2])
```

Let's break down the behavior we just saw:

- Multi-dimension Numpy arrays are indexed by a comma-separated set of indexes (one per dimension)
- Each index set can be a full `start:stop:step` triple, like traditional lists.
- 2D arrays follow **row major index ordering** (following typical linear algebra standards).


Numpy arrays have a plethora of useful *object attributes* and *object methods* - far more than I can reasonably cover here. Here are some important ones in action:

```python
# Get the size and shape of an array:
print(f"Our array has a size of {array_2d.size}; it's shape is {array_2d.shape}")

# Get the transpose of our matrix:
print("Our transposed array:")
print(array_2d.T)  # Alternative, array_2d.transpose()

# Get max/min values:
print(f"The max/min of our array is: {array_2d.max()}, {array_2d.min()}")

# Get the location of the max value:
print(f"The index of the maximum value in our 1D array is: {heights.argmax()}")

# Other math functions:
print(f"The standard deviation of our 2D array is: {array_2d.std()}")
print(f"The mean along axis 1 is:")
print(array_2d.mean(axis=1))

```

There is a lot of functionality associated with our arrays! I implore you to explore them in detail.


## Creating Numpy Arrays

Obviously, turning lists into arrays is sub-optimal. 
Fortunately, there are a lot of built-in tools for creating arrays:


### Creating Sequential Data: `arange` & `linspace`

These two Numpy functions create serial vectors. `arange` uses a "start-stop-step"
approach, while `linspace` uses a "start-stop-number of points" strategy.

```python

```

One note on `arange` is that it can be tricky sometimes. ENDPOINTS and DATATYPES


### Creating Empty-ish Arrays: `zeros`, `ones`, and `eye`


### The Reality: Array Data Comes from Files and Calculations
In the end, you'll create arrays by populating them via data from files or data from calculations.

To illustrate, let's make sine and cosine curves over the inteval [$-\pi$, $\pi$].
We will plot this data, so start by importing Matplotlib and turning on in-line plotting:

```python
import matplotlib.pyplot as plt
%matplotlib inline
```

```python
# Create x data spanning desired interval
x = np.arange(-np.pi, np.pi, 0.1)

# Calculate data:
y_cos = np.cos(x)
y_sin = np.sin(x)

# Plot!
plt.plot(x, y_cos, label='Cosine')
plt.plot(x, y_sin, label='Sine')
plt.legend()


```

Many times, you will find yourself populating data from file. 
There are file readers for different formats that return data in Numpy arrays
(or derivatives). 
Other times, you will need to create your own file reader. 
While we won't explore that here, I offer two pieces of advice:

- Instead of creating a zero-element array and then appending new values to
the end (growing array size progressively as the file is read), try to 
determine the number of entries (e.g., number of lines in a text file) first
and then creating an array with `numpy.zeros` of the correct size. This will
make for more efficient code.
- If you have a text file where each column is a different variable (e.g., 
time, pressure, temperature, etc.), eschew just dumping things into a 2D 
array, requiring the user needing to remember what-column-corresponds-to-what-value.
Instead, consider a dictionary of 1D arrays or 
[Numpy's structured arrays](https://numpy.org/doc/stable/user/basics.rec.html).


## Numpy Math Functionality

constants, functions, submodules, etc.


## Numpy Data Types


## Numpy Logical Indexing


## Masked Arrays



