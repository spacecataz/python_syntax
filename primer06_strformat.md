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

<!-- #region -->
String Formatting: The Gory Details
===================
Creating well-formatted strings is one of the most useful skills in any language.  It is necessary for creating readable ASCII files, clean plot titles, and text that reflects the result of a dynamic calculation.
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



Raw Strings & Special String Literals
-----------
So what if we *don't* want string interpolation?  This happens a lot- when writing file paths or regular expression syntax.  If you try to do this, string interpolation can cause exceptions or have other unsavory impacts on our work.  Take this example:

```python
file_path = ''
print(file_path)
```

```python

```
