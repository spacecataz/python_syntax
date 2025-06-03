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

We should note that it's pronounced *Num-__Pie__*, that is, *Num*ber *Py*thon.
It's not *__NUM__-pee*, as in *rhymes with lumpy*. That would be just silly.


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
need to do this one element at a time:

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
import numpy as np

temp = np.array([42.1, 42.5, 43.1, 42.9, 43.3, 43.9])
print(temp)
```

## Matplotlib Style Sheets

The default look and feel of Matplotlib plots can be quite boring.
Take, for example, this very boring plot:

```python
x = np.arange(0, 4*np.pi, 0.01)
y = np.sin(x)
plt.plot(x, y)
```

It is possible to make this much better by changing the following items:

- the default tick label fonts and font size
- the default line width
- the background color
- turn on/off the plot grid
- change the default line width and color order

...and much more. There are several ways to do this, the most obvious is customization when you create the figure/axes/line objects.
However, this is a lot of repeat work every time you create a plot.
It is possible to set defaults by [changing the `matplotlibrc` configuration file](https://matplotlib.org/stable/tutorials/introductory/customizing.html#customizing-with-matplotlibrc-files).
It is also possible to create "style sheets" that customize certain aspects of your plots and load them on command.

There are a number of built-in style sheets that can be used to create distinctive styles with very little effort.
Take this example:

```python
plt.style.use('fivethirtyeight')
plt.plot(x,y)
```

[You can see the possible built-in style sheets in action here](https://matplotlib.org/stable/gallery/style_sheets/style_sheets_reference.html)
You can also get a list of available built-in style sheets using this command:

```python
print(plt.style.available)
```



```python

```
