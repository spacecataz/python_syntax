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

Scientific Python: Numpy and Matplotlib
## What's Matplotlib?

Matplotlib was originally built to be able to create plots in python the same easy way they are done in matlab. Hence the name: Mat(lab) plot(ting) lib(rary). Matplotlib has, since then, far exceeded (in at least some ways) the convenience and usefulness of matlab plotting capabilities. 

To use matplotlib, as with any python module, you must first import it. We ~~almost never~~ often don't import the base matplotlib module. Instead, we import the pyplot submodule. As with numpy, the submodule is pronounced *__Pie__-plot* and not *__Pee__-plot*. The latter is what Canadian boys (and hardcore girls) learn to do in winter.

```python
import matplotlib.pyplot as plt
# it is VERY common to import pyplot as plt
import numpy as np
# we're going to use numpy to generate data that we can plot!
```
## Matplotlib Style Sheets

The default look and feel of Matplotlib plots can be quite boring.
Take, for example, this very boring plot:

```python
x = np.arange(0, 4*np.pi, 0.01)
y = np.sin(x)
plt.plot(x, y)
```

If you try this example in a console or notebook on jupyterhub, the plot will automatically appear after you enter the *plot()* command.

If you try this on a different (non-jupyter) setup, you may well have to tell python to *show()* the plot. You would add the following command.

```python
plt.show()
```

It is possible to make our example plot much better by changing the following items:

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