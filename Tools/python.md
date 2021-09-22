# Python

Python is a powerful language; but with that power comes complexity! Below are just some questions you might stumble upon when looking at or writing Python code.

### What does this thing mean?

<details><summary>Why do some functions put * before arguments?</summary>

The asterisks refer to a variable number of arguments; it is possible for functions to support an arbitrary list of arguments:

```python
def test_var_args(farg, *args): # Note the asterisk
    print("formal arg:", farg)
    for arg in args:
        print("another arg:", arg)

test_var_args(1, "two", 3)

# formal arg: 1
# another arg: two
# another arg: 3
```

You can even support unlimited keyword arguments:

```python
def test_var_kwargs(farg, **kwargs): # Note the double asterisks
    print("formal arg: ", farg)
    for key in kwargs:
        print("another keyword arg: {}: {}".format(key, kwargs[key]))

test_var_kwargs(farg=1, myarg2="two", myarg3=3)

# formal arg: 1
# another keyword arg: myarg2: two
# another keyword arg: myarg3: 3
```

_Why this is useful when you could just pass in a list or a dictionary manually instead?_

There are (at least) 2 answers to this:

1. It's often more expressive to use arguments directly rather creating collections to wrap them and then immediately unwrap them in the function
2. This enables the construction of wrapper functions/decorators that can handle all possible combinations of function arguments
</details>

<details><summary>Can I inherit from multiple base classes?</summary>

It is possible for a Python class to inherit from multiple base classes:

```python
class Engine:
    def __init__(self, engine_name):
        self.engine = engine_name

class Wheels:
    def __init__(self, number_of_wheels):
        self.number_of_wheels= number_of_wheels

class Car(Engine, Wheels):
    def __init__(self, engine_name, number_of_wheels):
        super(Engine).__init__(engine_name)
        super(Wheels).__init__(number_of_wheels)
```

When inheriting from multiple base classes the base classes are often referred to as **mixins** instead (as they are mixed-into the class)

This can come in handy when you want to break down a class into multiple reusable components. For example I could now define a **Bicycle** class using just the **Wheels** mixin:

```python
class Bicycle(Wheels):
    def __init__(self, number_of_wheels):
        super(Wheels).__init__(number_of_wheels)
```

However if we'd defined Car using a Vehicle base class like so:
```python
class Vehicle:
    def __init__(self, engine_name, number_of_wheels):
        self.engine = engine_name
        self.number_of_wheels= number_of_wheels

class Car(Vehicle):
    def __init__(self, engine_name, number_of_wheels):
        super().__init__(engine_name, number_of_wheels)
```

Then this would no longer be possible (as a bicycle does not have an engine).
</details>

<details markdown="1"><summary markdown="1">

What is the `super` keyword?
</summary>

When inheriting from a base class, you'll often end up reusing the same method names as the base class, the most common example being the `__init__` function.

- When this happens, how do you call the base class method from child class?

Python solves this problem by providing the `super()` method, which allows access to any of the base classes methods:

```python
class Rectangle:
    def __init__(self, length, width):
        self.length = length
        self.width = width

class Square(Rectangle):
    def __init__(self, length):
        super().__init__(length, length)
```

You can also use `super` to access base methods from further down the inheritance hierarchy by providing the target class as a parameter:

```python
class ColouredSquare(Square):
    def __init__(self, length, colour):
        self.colour = colour
        super(Rectangle).__init__(length, length) # Calls __init__ from Rectangle and not Square
```

</details>
