# Poetry

<details markdown="1">
<summary markdown="1">
What is Poetry?
</summary>

Poetry is a dependency management tool for Python - it is a great solution for installing & tracking libraries that we're using, and avoiding dependencies causing conflicts. It solves a similar set of problems to the default package manager "pip", but also handles virtual environments effectively allowing us to make setting up & developing with the project easier.
</details>

<details markdown="1">
<summary markdown="1">
My virtual environment seems to be in a bad state?
</summary>

Sometimes your virtual environment managed with Poetry can get itself into a funny state - the classic "turn it off & on again" approach is to clear out your existing virtual environment folder and try installing from scratch.

Either:
* Delete the `.venv` folder directly
* Run `poetry env remove python` to programmatically remove that folder (particularly useful if your virtual environment is not stored alongside your project)
And then run a fresh `poetry install`.

</details>