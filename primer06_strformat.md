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

<!-- #region -->
String Formatting: The Gory Details
===================

Creating well-formatted strings is one of the most useful skills in any language.  It is necessary for creating readable ASCII files, clean plot titles, and text that reflects the result of a dynamic calculation.
The fundamental issue is inserting values stored within variables, whether they are floating point, integers, or strings
themselves, into new strings while keeping the output organized and readable.
Let's explore the syntax for doing this in Python.

String formatting comes via a process known as **string interpolation**.  String interpolation is when the python interpreter takes a string value as typed and replaces certain characters with characters not easily typed- newlines, the values from variables, or special symbols.  To indicate where in a string interpolation should occur, we'll use two tools: **escape characters** and **replacement fields**.  There are different types of strings and string methods that allow us to control when, where, and how interpolation happens.

Many of the concepts explored here in Python exist in other programming languages.  The functions, syntax, and end result can, of course, vary with each language.


Escape Characters
-------------
Let's start with **escape characters** (also known as **escape sequences**), which give us a way to type the untypeable.  To wit,
<!-- #endregion -->

```python
print( 'I want\tto add some\ttabs in here\t.')
```

When Python prints the string to screen, it performs interpolation.  Backslashes indicate what characters to 'escape' (you'll hear people say that you need to "escape that character", which means to precede it with a backslash).  In this case, an escaped "t" (`\t`) equates to a tab character.  Let's look at some more:

```python
print('New lines \n are done with \\n') # You can "escape an escape" with a double backslash.
print('If you need \'nested quotes\', you can escape them.')
print('Backspaces will delete characters'+6*'\b') # Note the multiplication of a string.
print('My favorite is the ASCII bell! \a')  # Only works in some environments
print('We can produce unicode characters, too: \u2665\U0001F40D') # I love me some python.
```

There are many useful escape characters, here is a complete list.  Note that some work differently in different environments.  For example, the form feed escape character (`\f`) doesn't work properly within Jupyter notebooks.
Additionally, the bell sequence (`\a`), a critical tool for creating annoying scripts that make your friends' computers
beep incessantly, does not produce an audible sound on some environments. In other words, **YMMV** (your mileage may vary).

| Escape Sequence | Result |
|:----------------|:-------|
|`\'`, `\"`|Prints quotes without closing string in source code.|
|`\f`|Form feed: moves cursor down one line without changing horizontal position.|
|`\r`|Carriage return: returns cursor to beginning of current line.|
|`\n`|Newline: form feed *and* carriage return. |
|`\b`|Backspace, will delete previous character.|
|`\t`|Inserts tab character.|
|`\a`|Plays system bell/alarm; only works in some environments. |
|`\\`|Inserts a backspace character.|
|`\o*`,`\x*`|Print character by octal or hexidecimal value, where `*` is replaced by a two-digit value.|
|`\u*`,`\U*` |Insert 16/32 bit unicode character, where `*` is replaced with a hexidecimal code.|
|`\N{name}`|Print unicode character `name`.|



Raw Strings
-----------
So what if we *don't* want string interpolation?  This happens a lot- when writing file paths or regular expression syntax.  If you try to do this, string interpolation can cause exceptions or have other unsavory impacts on our work.  Take this example:

```python
# In Windows, file paths uses backslashes instead of forward slashes:
file_path = 'C:\Users\new_user\toobox\backup_scripts'

# Printing this is going to cause a lot of problems!
print(file_path)
```

Oh, no! The python string tried to *interpolate* all of my slashes into escape sequences. I could brute-force this by using double slashes, which is the escape sequence to get a single backspace:

```python
# Let's use double-slashes to get things right:
file_path = 'C:\\Users\\new_user\\toobox\\backup_scripts'

# Printing this does not cause problems:
print(file_path)
```

This is a clumsy solution, however. What we want is a way to *turn off interpolation*. We want a **raw string**.
Raw strings are preceded by either `r` or `R`:

```python
# Let's use double-slashes to get things right:
file_path = r'C:\Users\new_user\toobox\backup_scripts'

# Printing this does not cause problems:
print(file_path)
```

Raw strings are often important when interpolation is giving you trouble. They can be crticial when you're working with strings that contain HTML, XML, or $\LaTeX$ syntax or URLs.

<!-- #region -->
## String Formatting with the `.format()` method


A very common task is to print strings that contain the values of variables inside of them.
For example, you might want to include a debug statement in your code that says, "At iteration `i`, our value is `x`" -- but with the current values of the integer `i` and float `x` in the string. The standard way to do this is to use the `.format()`
string object method.

This function uses curly braces (`{}`) and string interpolation to put values into our strings. For example,

<!-- #endregion -->

```python
# Declare some values:
i = 13
x = 5.321

# Print those values:
print('At iteration {},  x={}'.format(i, x))
```

Quite simply, each set of curly braces is replaced with what we would get had we typed `print(argument)` for each argument given to the `format()` method in turn.
We cannot have more sets of curly braces than arguments to `.format()` (with some exceptions, as we'll see below).

```python
print('{} {}'.format(1))
```

If we want to actually print curly braces, we can escape them- not with backslashes, but with double-curly-braces:

```python
print('Braces look like this: {{ and this: }} . We can still print out values: {}'.format(i))
```

Again, the default action is to pair up each pair of braces with each argument to `format()` in order. There are two other ways to pair braces and variables, however: by *number* or by *keyword argument*. To illustrate,

```python
# Use numbers to select values to print:
print("Variable #1 = {1} and Variable #0 = {0}. Don't forget, Variable #1 = {1}".format(i, x))

# Or, use arbitrary keywords to set names:
print("Variable #1 = {v2} and Variable #0 = {v1}. Don't forget, Variable #1 = {v2}".format(v1=i, v2=x))
```

Note the flexibility this yields: we can now add our variables to `format()` in any order and tell it *exactly* where we want each variable. Concerning the kwarg method, we can use any name we want, not ust `v1`, `v2`, etc.

Our next challenge is *formatting the values* to get *exactly* what we want. Take, for example, either $\pi$, or $\mu_0$ (the permeability of free space), or the mass of a proton, $m_{proton} = 1.67262192 \times 10^{-27}$. Any of these look *ugly* when printed to screen:

```python
import numpy as np

# proton mass
mp = 1.67262192E-27

# mu_naught, permeability of free space:
mu = 4*np.pi*1E-7

print('pi = {}'.format(np.pi))
print('mu-naught = {}'.format(mu))
print('proton mass = {} kg'.format(mp))
```

Consider another situation where we just want things to line up vertically for ease of reading:

```python
# Create a dictionary of "users" and their ages.
user_age = {'Ralph':6, 'Bartholomew':105, 'Nicholas':42}

# Print the info to screen:
for i, name in enumerate(user_age):
    print('User #{0} is {1} (Age {2})'.format(i, name, user_age[name]))
```

This is *fine*, but nothing really lines up past the name of the user. For long lists with more information, it would be great if everything lined up into clear columns. This is a common issues when writing out text-based data files that you want to be able to scroll through by eye.

The solution to these issuse are **format codes**. Format codes are nothing new- they specify how to precisely convert the value into a string, including the number of characters to use, the number of digits past the decimal point, and much, much more.

Let's return to the above examples, but use format codes to clean things up visually. We specify format using a colon *after* we designate the variable to be printed.

```python
# Represent numbers in different ways and sizes.
# Note the format code follows a colon.
print('pi = {:.7f}'.format(np.pi))
print('mu-naught = {:+10.3E}'.format(mu))
print('proton mass = {:+014.5E} kg'.format(mp))

# Print our user names and ages, but specify the width of each variable.
for i, name in enumerate(user_age):
    print('User #{0:02d} is {1:^15s} (Age {2:03d})'.format(i, name, user_age[name]))
```

There's a lot going on here, from how we print numbers (e.g., how many digits, scientific formatting, plus/minus sign, preceding zeros) to the total number of characters and the justification (in this case, centered).
Rather than pick apart this example further, let's jump into the gory details.


## The String Format Specification Mini-Language

Our precise formatting is dictated by the [Python string formatting mini-language.](https://docs.python.org/3.4/library/string.html#format-specification-mini-language)
Yes, this means learning more syntax, but do not dispair- much of this directly translates to other languages, in part or in whole.

Our general syntax is **`{value:format}`**, where the format has the following general layout:

|format_spec | `[[fill]align][sign][#][0][width][,][.precision][type]`|
|:----------:|:-------------------------------------------------------|
|`fill`      |  Use with `align` to set non-space fill character |
|`align`     |  Alignment: left (<),  right (>), centered (^) , or use `fill` between sign and digit (=)|
|`sign`      |  Include sign of number always (+), only when negative (-), or use a space for positive numbers ( )|
|`#`         | Use alternate form of number. |
|`0`         | Pad numbers with preceding zeros to fill full width. |
|`width`     |  **TOTAL** number of characters to use, including decimals, etc. |
|`,`         | Use commas to delimit thousands. |
|`precision` |  Number of digits after decimal to include. |
|`type`      |  Format for value (see table below). |

The `type` specifier is a single character that dictates how values are converted into strings.
There are some specifiers that work with floating point values and others that
work with integers.
String values get one specifier: `s`.
Note that it's not necessary to include a specifier. Python will choose
default behavior for strings, integers, and floats.
The table below specifies *some* but not *all* of the type specifiers:

| Application | `type` | Description |
|:------------|:------:|:------------|
| **Strings** | `s` | Display as a string (default for strings). |
| **Integers**| `d` | Basic digit (default for integers). |
|             | `b` | Binary digit (e.g., 10000011 instead of 131.) |
|             | `x` or `X` | Hexidecimal digit. |
| **Floats**  | `g` or `G` | Either fixed-point or exponential depending on value (default for floats*) |
|             | `f` or `F` | Fixed point representation. |
|             | `e` or `E` | Exponential (scientific) notation. |
|             | `%`        | Convert to percentage ($\times 100$) and include percent sign. |

Note that for floats, the default behavior is similar to `g` with some minor
differences on how text is handled. For any specifier where there is a
lower- and upper-case option (e.g., `e` and `E`), the upper case option will
use upper-case letters for the exponent notation *and* any not-a-number values
(e.g., `INF` and `NAN` instead of `inf` and `nan` for infinity and not-a-number,
respectively). Similarly, `X` will yield capital letters, while `x` will
give lower case.

You don't need to use all or *any* of the format specifier options listed
above. Use what you need to get the best look and readability of your output
strings.

## String Formatting for Datetimes

While most of our formatting needs are handled above, there is one special
case that we have already discussed: `datetime` objects.
Datetimes have their own formatting mini-language that integrates into
the above specifiers.

```python

```

## In-String Formatting: F-Strings



```python


```

## OBSOLETE: Formatting with %

---
<span style="color:red">**WARNING**:</span> Percent-sign format specification is obsolete and should no longer be used in Python.

---
It is possible to use percent signs (`%`) in place of the `format()` method or f-strings. This syntax closely follows what is used by `printf` in C. This approach is obsolete and should not be used. If you encounter it in the wild, it will look like this:

```python
print('pi = %.7f'%np.pi)
```

When you see this string formatting approach, it's best to replace it with modern counterparts (either `format()` or f-strings).


```python

```

```python

```
