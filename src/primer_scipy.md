---
jupyter:
  jupytext:
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.17.3
  kernelspec:
    display_name: Python 3
    language: python
    name: python3
---

Scientific Computations: Scipy
===============

In the numpy primer, we saw how we can use the numpy module to represend data as
true multidimensional arrays that we can operate on efficiently and in a way
that mirrors how we do science and engineering math.

What about more complex operations though? How do we find the root of a function? What about integrating a system of equations?

Fear not. We have the scipy module. Now, Numpy *does* include methods to perform some of the topics we approach here, but not all and not with as much flexibility or efficiency.

## Function optimization and root-finding
One of the age-old questions of engineering and science is **How do we find the zero of a function, i.e. how do we find the value of $x_0$ such that the function $F(x)$ satisfies $F({x_0})=0$?** Another related question is **For which value $x_\mathrm{min}$ is $F(x)$ a minimum, i.e. $F(x_\mathrm{min}) < F(x)$ for all other values of $x$?** (This question can be turned to a maximum and it's the same question. Just multiply the function by a minus sign.)

Let's look at some random function to test our algorithms. We'll use the following function

$$F(x) = e^x - 3$$.

That function has a zero $F({x_0}) = 0$ for $e^{x_0} = 3$ or $x_0 = ln(3)$.

We can define and test our function with the following code. We can even check that our zero is indeed in the correct place.

```python
import numpy as np
import scipy.optimize as opt

def fnc(x):
    return np.exp(x)-3

x0 = np.log(3)
print(x0)
print(fnc(x0))
```
(Note that we are using the function np.log because the "default" log function in numpy is the base $e$ or natural logarithm. The base-10 logarithm function is np.log10(). Don't get confused!)

That value of approximately $x_0 = 1.098612$ is the **exact** value of the zero, or the **analytical** solution.

What if I don't know what the function is? Or if I just forgot how to manipulate logarithms and exponentials? We can use many algorithms you should have learned in a numerical methods course, such as
* bisection method
* secant method
* Newton method
* and many more!

In scipy, those are contained within the scipy.optimize submodule. The main function we can use is *root_scalar* (for a function that returns a scalar).

```python
import numpy as np
import scipy.optimize as opt

def fnc(x):
    return np.exp(x)-3

x0 = np.log(3)
print(x0)
print(fnc(x0))

##Using the bisection method in the interval 0 to 3
sol = opt.root_scalar(fnc, bracket=[0, 3], method='bisect')
sol.root, sol.iterations, sol.function_calls
```

On my system, the correct answer was found after 41 iterations and 43 function calls. 

```
##Using the Newton method with initial guess x0 = 0
##The newton method requires a derivative!!
def fnc_p(x):
    return np.exp(x) ##the derivative of e^x is e^x!!

sol = opt.root_scalar(fnc, x0=0, method='newton', fprime=fnc_p)
sol.root, sol.iterations, sol.function_calls
```
This time, the zero is found with 7 iterations and 14 function_calls! A lot less computational work!

```
##Using the BrentQ method with bracket [0,3]
##The BrentQ method does not require a derivative!!

sol = opt.root_scalar(fnc, bracket=[0,3], method='brentq')
sol.root, sol.iterations, sol.function_calls
```
This time it's 10 iterations, but only 11 function calls. More iterations, but less work, so this is likely more efficient than Newton.

We can also let the function decide which method to use according to its own internal logic.

```
##Using default method settings

sol = opt.root_scalar(fnc, bracket=[0,3], fprime=fnc_p)
sol.root, sol.iterations, sol.function_calls
```
From the results, it looks like root_scalar() uses brentq as a default.

You can get the full details here https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.root.html#scipy.optimize.root

## Function Integration

### Integrating a System of Equations
Baumgartner jumped from roughly 30 km altitude to break the sound barrier in free fall. The system of equations would look like

$$
\frac{dx}{dt} = V
$$
$$
\frac{dV}{dt} = \frac{1}{2}\frac{\rho_\mathrm{air} V^2 A_\mathrm{front} C_D}{m} - g
$$

where $x$ is the altitude in m, $V$ is the velocity in m/s, $t$ is time in seconds, $rho_\mathrm{air}$ is the air density in $\mathrm{kg}/\mathrm{m}^3$, $A_\mathrm{front}$ is the frontal area in $\mathrm{m}^2$, $C_D$ is the drag coefficient (unitless), $m$ is the object (here Baumgartner's) mass, and $g$ is to local gravitational acceleration. We will use, in the scipy.integrate submodule, the solve_ivp function.
First, we need to define a function for the derivatives! Let's use the example from the scipy documentation for solve_ivp and modify. https://docs.scipy.org/doc/scipy/reference/generated/scipy.integrate.solve_ivp.html
The example is:

```
import numpy as np
import scipy.integrate as int

def deriv(t,y):
    return -0.5 * y
```

Then, we solve by using

```
sol = int.solve_ivp(deriv, [0, 10], [3])
```
Now, we modify the differential equation for Baumgartner. [Note that we are hard-coding the values of the constants. We should pass those as parameters.]

```
import numpy as np
import scipy.integrate as int

def deriv(t,y):
    x = y[0]
    V = y[1]
    rho_air = 1.2   #air density set to 1.2 kg/m^3
    A_front = 0.09  #frontal area set to 0.09 m^2
    C_d     = 0.3   #Drag coefficient set to C_d = 0.3
    g       = 9.81  #Gravitational acceleration set to 9.81 m/s^2
    m_obj   = 80    #Object mass set to m_obj = 80 kg
    dxdt = V
    dVdt = 0.5*rho_air*V**2*A_front*C_d/m_obj - g
    derivs = 0 *y     #ensure the output variable has the same size and shape as the input
    derivs[0] = dxdt  #place the values of the derivaties in the output object
    derivs[1] = dVdt  #with correspondance, i.e. y[0] -> x, derivs[0] -> dx/dt, etc
    return derivs
```
To integrate the system, we call solve_ivp with the correct time span and 2 initial conditions: $x(0) = 30 000$ and $V(0) = 0$.

```
sol = int.solve_ivp(deriv, [0, 200], [30000,0])
```
We can now use matplotlib to plot look at the resulting curve. (There's a document explaining matplotlib, but we'll show the bare example here, using pyplot.)

We can look at vertical position, in km (hence the factor of 1000)
```
import matplotlib.pyplot as plt #import pyplot from matplotlib
plt.plot(sol.t, sol.y[0]/1000)  #plot position (/1000 to be in km) vs time
plt.show()                      #plt.show() creates the actual plot window
```
and we can look at the velocity afterwards
```
plt.plot(sol.t, sol.y[1])  #plot position (/1000 to be in km) vs time
plt.show()                      #plt.show() creates the actual plot window
```

### Taking the example further to be more realistic
We make several assumptions in our example: $\rho_\mathrm{air} = \mathrm{constant}$, $C_\mathrm{drag} = \mathrm{constant}$, $g = \mathrm{constant}$. All of these are wrong. How would we improve on these approximations? We can define functions for the different variables. For example, gravity varies depending on distance from the Earth's surface. We can remind ourselves of the square formula using Wikipedia https://en.wikipedia.org/wiki/Gravity_of_Earth

$$
g(x) = g_0 \left( \frac{R_E}{R_E + x} \right)^2,
$$

where $R_E = 6371.00877$ km is the Earth's radius, $x$ is the altitude (careful about units here) and $g_0=9.80665$ m/s^2 is the gravitational acceleration at sea level.

A gravitational acceleration function can be written
```
def g_h(h):
    ## Inputs: Altitude, h [km]
    ## Outputs: Gravity, g_x [m/s^2]
    g_0 = 9.80665
    R_E = 6371.00877
    return g_0 * (R_E/(R_E+h))**2
```
We then modify our derivative function to call our gravity function at every call.

```
def deriv(t,y):
    x = y[0]
    V = y[1]
    rho_air = 1.2   #air density set to 1.2 kg/m^3
    A_front = 0.09  #frontal area set to 0.09 m^2
    C_d     = 0.3   #Drag coefficient set to C_d = 0.3
    g       = g_h(x/1000) #Gravitational acceleration calculated from model (altitude is in km), g in m/s^2
    m_obj   = 80    #Object mass set to m_obj = 80 kg
    dxdt = V
    dVdt = 0.5*rho_air*V**2*A_front*C_d/m_obj - g
    derivs = 0 *y     #ensure the output variable has the same size and shape as the input
    derivs[0] = dxdt  #place the values of the derivaties in the output object
    derivs[1] = dVdt  #with correspondance, i.e. y[0] -> x, derivs[0] -> dx/dt, etc
    return derivs
```
Air density can be modelled using the standard atmosphere. Extending the model is starting to get complicated, but we can find packages that have implemented models. For example, the 1976 standard US atmosphere model is implemented here https://scikit-aero.readthedocs.io/en/latest/skaero/atmosphere/.

A classic text, "Fluid Dynamic Drag" by Hörner, can be consulted to find appropriate functions at a variety of speeds. https://ia800606.us.archive.org/17/items/FluidDynamicDragHoerner1965/Fluid-dynamic_drag__Hoerner__1965_text.pdf.

Each model would then be called within our derivative function, deriv(), that will itself be called by solve_ivp().
