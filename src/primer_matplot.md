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