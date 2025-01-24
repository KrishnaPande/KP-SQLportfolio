# Learning Python Package Structures

## Step 1: Understand Modules and Packages

### What is a Module?
- A single `.py` file that contains Python code (e.g., `fields.py`).

### What is a Package?
- A directory containing a special file named `__init__.py`, making it a package.
- A package can include multiple modules and sub-packages.

### Resources
- [Official Python documentation on modules](https://docs.python.org/3/tutorial/modules.html)
- [Official Python documentation on packages](https://docs.python.org/3/tutorial/modules.html#packages)

---

## Step 2: Practice Simple Examples

### Create a Simple Package
1. Create a folder structure:
    ```
    mypackage/
    ├── __init__.py
    ├── module1.py
    ├── module2.py
    ```

2. Example contents of `module1.py`:
    ```python
    def greet(name):
        return f"Hello, {name}!"
    ```

3. Import in a script:
    ```python
    from mypackage.module1 import greet
    print(greet("World"))
    ```

### Experiment with Sub-Packages
1. Add a sub-folder:
    ```
    mypackage/
    ├── __init__.py
    ├── module1.py
    ├── subpackage/
        ├── __init__.py
        ├── module3.py
    ```

2. Import from deeper levels:
    ```python
    from mypackage.subpackage.module3 import some_function
    ```

---

## Step 3: Learn About `__init__.py`
- Understand how `__init__.py` controls package behavior.
- Use it to define shortcuts for imports or initialize package variables.

### Example
```python
# mypackage/__init__.py
from .module1 import greet
```

---

## Step 4: Explore Project Layouts

### Common Layout for Larger Projects
```
myproject/
├── mypackage/
│   ├── __init__.py
│   ├── module1.py
│   ├── subpackage/
│       ├── __init__.py
│       ├── module3.py
├── tests/
│   ├── test_module1.py
├── setup.py
├── README.md
```

---

## Step 5: Learn Packaging and Distribution
- Learn how to create and distribute your package using `setuptools`.
- Learn about `pyproject.toml`, `setup.cfg`, and publishing to PyPI.

### Resources
- [Python Packaging Authority Tutorial](https://packaging.python.org/en/latest/tutorials/packaging-projects/)

---

## Step 6: Explore Advanced Concepts

### Topics to Explore
1. **Namespace Packages**: For shared namespaces across multiple distributions.
2. **Dynamic Imports**: Using `importlib`.
3. **Package Initialization Logic**: Advanced `__init__.py` tricks.

---

## Tools and Exercises
- Use `cookiecutter` templates for standard layouts.
- Check GitHub repositories for examples.
- Practice building, installing, and importing packages locally using `pip install .`.

---

Start small, and gradually experiment with increasingly complex setups. Let me know if you'd like to dive deeper into any of these topics!
