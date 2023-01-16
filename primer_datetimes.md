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

# Python's Datetime Module

A huge challenge for any programming language is handling time.
Users *often* need to handle timeseries data.
It is possible to do this with seconds, minutes, or hours from epoch; day-of-year (DOY) plus fraction of day; or some other method that represents time with integers or floating point values.
However, these are often clumsy and inadequate; what we really want is _date and time_ as an easily manageable object.

Enter __`datetime`__, a package specifically for handling dates and times. The most critical object classes within this module are `datetime` (yes, they really did call it the same thing as the module) and `timedelta`. Each have very useful object methods to help us handle the intricacies of time. Even better, `datetime` objects have become the de-facto standard way to represent time, meaning easy integration with Matplotlib and other packages. Only when more precision is needed (e.g.,  when dealing with leap seconds or other challenges) are other tools needed.

[Be sure to see the full documentation here.](https://docs.python.org/3/library/datetime.html)

There are two other modules worth investigating that I won't cover here:

- `calendar`, which includes a ton of utilities that range from looping over days-of-the-week to determining if a given year is a leap year or not.
- `zoneinfo`, which can be used with `datetime` to handle timezone information and conversions.

## `datetime` basics

Let's start by making some `datetime.datetime` objects and seeing how they work.

```python
# Let's import datetime and immediately rename it.
import datetime as dt

# Build a datetime by specifying year, month, day, hour, minute, second, or microsecond.
t1 = dt.datetime(2010, 9, 14, 12, 31, 0, 254)
print(t1)

# You don't need all of that, though.
t2 = dt.datetime(2008, 1, 18, 22, 1) # Only up to minute.
print(t2)

# What about the time right now?
t3 = dt.datetime.now()
print(t3)
```

As you can see, datetime makes it pretty easy to create a date and a time. Printing spits out a nice-to-look-at format; there are some other methods to create other, widely-accepted formats:

```python
print(t1.isoformat()) # ISO formatted date/time
print(t1.timestamp()) # POSIX timestamp date/time.
```

This is nice, but how do *we*, as programmers, get info from a datetime object? With its attributes, of coures!

```python
print(t1.hour)
print(t2.year)
print(t3.microsecond)
```

While it is possible to create a simple `date` object or a `time` object, those are rarely as useful as the full `datetime` object. They work similarly, so I won't cover them here.

## `timedelta` basics

The other critical object is the `timedelta` class. This is an object that contains some length of time between two `datetimes`. There are two basic 
ways to construct these objects

```python
# Express the time difference explicitly
delta1 = dt.timedelta(days=10, hours=5, seconds=2)
print(delta1)

# Subtract to time deltas
delta2 = t1 - t2
print(delta2)
```

`timedelta` objects have attributes that indicate how much time is covered: `.days`, `.seconds`, `.microseconds`. **The total time is all three of these summed together, not any one individual value.** To see the _total_ time difference as one number, use the `.total_seconds()` method.

```python
print(delta1.days)
print(delta1.seconds)
print(delta1.total_seconds())
```

```python

```
