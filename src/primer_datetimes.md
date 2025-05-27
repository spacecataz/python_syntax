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

The other critical object is the `timedelta` class. This is an object that contains some length of time between two `datetimes`. There are two basic ways to construct these objects: either through explicitly generating them, or (more commonly) **by subtracting two existing `datetime` objects**:

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

## Datetimes and Strings: Formatting and Conversion

Turning strings into datetimes and datetimes into strings is a fundamental process when handling dates and times.
It is not only critical for communicating times to humans, but also for loading values into `datetime` objects when they are written in human-readable form.

Let's start with how `datetime` objects interface with the f-strings and the Python string formatting mini-language:


```python
# Default formatting: 
print(t1)

# A custom format using time-related format codes:
print(f'Something cool happened on {t1:%Y-%m-%d %H:%M:%S}')

# Here's time printed using a 12-hour clock and the AM/PM signifier:
print(f'The time is {t1:%I:%M:%S %p}')
```

Note the formatting codes we used to create a readable time: they use the percent sign (`%`) and a single letter to elicit some behavior. These format codes follow language standards of C, plus some "extra" format codes not standard in C but following ISO standards. [The full list can be found here](https://docs.python.org/3/library/datetime.html#strftime-and-strptime-format-codes) but the most useful ones are listed below:


|Unit | Directive | Meaning |
|-----|-----------|---------|
|Year |%y, %Y     | Year without/with century (e.g., 01 or 2001). |
|Month|%m         | Month as a zero-padded number (01, 01, ..., 12). |
|     | %b, %B    | Month full or abbreviated name (e.g., Feb or February). |
|Day  | %a, %A    | Weekday full or abbreviated name (e.g., Sun or Sunday). |
|     | %d        | Day of month as a zero-padded number (01, 02, ..., 31). |
|     | %j        | Day-of-year as a zero-padded decimal (e.g., 001, 002, …, 366). |
|Hour | %H        | Hour as a decimal using a 24 hour clock. |
|     | %I        | Hour as a decimal using a 12 hour clock.|
|     | %p        | Local AM or PM. |
|Minute| %M       | Minute as a zero-padded decimal (e.g, 05, 59).|
|Second| %S       | Second as a zero-padded decimal (e.g., 05, 59).|



In the examples above, note how we incorporate non-directive characters to improve our formatting: the dashes, colons, and spaces. It is perfectly legitimate to include these characters in our format code.

Converting `datetime` objects to-and-from strings uses the above format codes and the `strftime` and `strptime` methods. 
The first creates a string *from* an existing datetime, while the latter *creates* a `datetime` from an existing time.
As a mnemonic, I say these methods as "string **from** time" and "string **put** time".
The former (`strftime`) works just like the f-strings above, except that you give the method a format code as a string argument:

```python
t1.strftime('%Y-%m-%d %H:%M:%S')
```

`strptime` is rarely called from an existing `datetime` object. Rather, we call it from the `datetime.datetime` base class to construct a new `datetime` object. Let's see it in action:

```python
# Get a string:
strtime = '2010-09-14 12:31:00'

# Turn it into a datetime:
t3 = dt.datetime.strptime(strtime, '%Y-%m-%d %H:%M:%S')
print(t3)
```

## Datetimes and Numpy


## Datetimes and Matplotlib
