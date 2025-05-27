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

Object Oriented Programming
===============
*Procedural programming*, or a programming approach that is centered around calling *procedures* (such as functions or subroutines) is a very common programming paradigm in scientific work.  However, it is many times advantageous to switch to *Object Oriented* programming.  This is where data structures, called *objects*, have internal variables and procedures, called *attributes* and *methods*.  The difference here is that external procedures need to be given the data structures on which to act (as *arguments*), in object oriented programming (OOP), object methods use the information stored within the object to act on something (typically, the object itself).  Let's use Numpy to illustrate the difference between the two.  Let's start by creating some simple arrays of numbers.

```python
import numpy as np
a1 = np.arange(0,50, 1)
```

Let's perform some actions using these arrays in a *procedural* manner.

```python
print(np.mean(a1))
print(len(a1))

```

Here, we used two functions (**np.mean** and **len**) to calculate the mean of the first array and calculate its length.  We also used the **print** function to view the results on screen.  Let's do the same thing in an OO way:

```python
print( a1.mean() ) # Note the parentheses.
print( a1.shape )  # No parantheses for attributes!
```

To get the mean of the array, we called the *object method*, **a1.mean**.  We provided no arguments to this function.  Instead of acting on an externally provided argument, it acts on the object to which it is associated.  Previously, to learn a characteristic of our data structure, we used a function, **len** to calculate the array's length.  However, this characteristic is stored within the object as an *object attribute*, and can be assessed using the usual dot syntax (but no trailing parentheses, because it's a variable, not a procedure that we call.)  

To learn more about OOP and how powerful it can be, let's create our own *class* of objects:

```python
class Example(object):
    '''
    Don't forget your doc string.
    '''
    pass
print('This is not part of our class definition.')
```

Defining classes is very straightforward.  Because this class doesn't do anything, we used **pass** to pass over adding more code.  All of our code pertaining to the class is tabbed over in the usual python style.  Our class definition ends when we stop tabbing over.  Note that when we declare our class, it must *inherit* its initial behavior from some existing class.  Because we don't have anything in mind for this class, we have it default from the base object, **object**.  We can now create objects of *class* **Example**:

```python
a = Example()
print(type(a))
print(a)
a?
```

We *instantiated* a new object of class **Example**.  A *class* is a type of object.  While objects of the same class can be different, they behave in a similar manner to other objects of the same class.  An example is two Numpy arrays that have different values inside.  They have distinct values, sizes, and other attributes; however, they have the same methods and do similar things.

Note the capitalization of our class' name.  It is standard practice to write class names in "camel case", where each word is capitalized but no spaces are used (LikeThisYouSee).

Our objects can have attributes assigned to them, like so:

```python
x = 3
a.x = 10
print(x)
print(a.x)
print(a)
```

Our new object is its own *namespace*.  That is how Numpy arrays each have their own **.size** attribute that has the same variable name, but one array's **.size** won't overwrite the **.size** of another.

We also see that printing out 'a' is marginally informative.  It tells us the class, the namespace where we can find the class definition, and the memory location of our object.

There are some very interesting built-in attributes, which always start with two underscores:

```python
print(a.__doc__)
print(a.__class__)
print(a.__dict__)
```

Now we see where objects store their docstrings!  We also see one way to see what class an object is.  Another way is the **type** function.  The **dict** attribute is a dictionary of all of the attributes contained within that object.

Let's create a class of objects that is a bit more interesting.  This class keeps track of a student's name and the scores of their homework assignments.  It provides ways to print the student's information to screen, calculate their grade, and update their information.

```python
class Student(object):
    '''Our second example class.'''
    def __init__(self, firstname, lastname):
        self.name = [firstname.capitalize(), lastname.capitalize()]
        self.homework = []
        
        return None # __init__ should always return none!
        
    def __str__(self):
        return '{0[0]} {0[1]} has completed {1} homeworks for a grade of {2}'.format(
            self.name, len(self.homework), self.calc_grade())
    
    def add_homework(self, score):
        '''Add a homework score to the student's record.'''
        self.homework.append(score)
        
    def calc_grade(self):
        '''Calculate a letter grade based on the student's homework scores.'''
        if len(self.homework)==0:
            return 'N/A'
        # Average score out of 100 points possible per assignment:
        score = sum(self.homework)/len(self.homework)
        # Map to a letter grade:
        if score>90:
            return 'A'
        elif score>80:
            return 'B'
        else:
            # etc...
            return 'F-'
        
```

There's a lot going on here, so let's take it one at a time.  We start off just like last time: declaring our class, inheriting from an existing class (**object**), and tabbing over.  

Next, we start declaring our *methods*.  These are function definitions that are attached to the object.  *The first argument to each object method should be **self***.  **self** is a special variable that means "Me!  Myself!  This object!"  It's how you access an object's attributes and methods even though that object has *yet to be instantiated*.  When you pass **self** as a method argument, you are making sure that the method can access the rest of the object's information. 

Our first method is **\_\_init\_\_**.  This is the *constructor*, or the function that is called when you create, or *instantiate*, an object from a defined class.  This is where we initialize our object, take arguments from the user, and turn those arguments into something useful.  **\_\_init\_\_** is very important!

Note that **\_\_init\_\_** is written to return **None**.  [Doing so is a best-practice that can avoid errors.](http://docs.quantifiedcode.com/python-code-patterns/correctness/explicit_return_in_init.html)

[There are many special methods that control the behavior of a class!](https://docs.python.org/2/reference/datamodel.html#special-method-names)  Like **\_\_init\_\_**, these start and end with double-underscores.  The next one we encounter is **\_\_str\_\_**.  This sets what happens when we use our object in the **print** function.  This method must *always return a string to the caller.*  There are dozens of these special methods that allow you to change how objects work.  They can set the behavior when your object is used in a mathematical statement, make the object work like a list or a dictionary, define what happens if your object is called as if it were a function, and control the behavior of your object when used in logical operators.  You can create very powerful and unique objects with these methods!

Next, we have two object methods that act on our object's attributes to some end.  First, we have **add_homework**, which extends the homework attribute by an additional score.  Then, we have **calc_grade**, which finds the average of all homework grades and assigns a letter grade to that homework.

Let's try out our class:

```python
st1 = Student('Saul', 'goodman')
print(st1)
st1.add_homework(94)
st1.add_homework(78)
print(st1)
```

Now let's suppose this class is very useful for us, but we would *also* like a class that has all of the same capability as this, but changes how we calculate the grade to include a special project.  We could write the whole class from scratch, but that would be repetitive and quite the waste of space.  Instead, let's *inherit* from our original class.

```python
class ProgStudent(Student):
    '''A specialized Student object that includes a special project score in the final grade.'''
    def __init__(self, *args, **kwargs):
        Student.__init__(self, *args, **kwargs) # Call the original init statement...
        # ...but add new commands:
        self.project_grade=0.0
        return None
    def add_project(self, score):
        '''Set the project score for the student.'''
        self.project_grade=score
    def calc_grade(self):
        '''Calculate a letter grade and include the project score.
        The project is worth three homeworks!'''
        # Average score out of 100 points possible per assignment:
        score = (sum(self.homework)+3*self.project_grade) / (len(self.homework)+3)
        # Map to a letter grade:
        if score>90:
            return 'A'
        elif score>80:
            return 'B'
        else:
            # etc...
            return 'F-'
```

```python
st2 = ProgStudent('John Raymond', 'Legrasse')
print(st2)
st2.add_homework(50)
st2.add_homework(75)
st2.add_homework(100)
st2.add_project(90)
print(st2)
```

Here, we have *inherited* the definition of our previous class, **Student**.  All of the old object methods and attributes are now included in this definition so we do not need to repeat that code.  We do, however, want to make this behave somewhat differently.  The old **\_\_init\_\_** statement was useful, so we don't want to replace it.  Rather, we call the original first to initialize a new object as we did the old.  Hence, we have the **self.homework** list and the **self.name** list.  We add a new method, **self.add_project**, which sets the score of the class project.  Finally, because our grade calculation is very different than the original, we replace it outright.  

In Python, inheritance is very important to creating new, customized, and powerful objects.  You can subclass anything, including default Python classes such as lists, dictionaries, and floats.  You can then alter them to make them more useful for yourself.  You can go further than that, however, and change **matplotlib.Axes** objects or **numpy.ndarray** classes to yield customized and powerful tools.  Be creative, and OOP can open a lot of doors for you!
