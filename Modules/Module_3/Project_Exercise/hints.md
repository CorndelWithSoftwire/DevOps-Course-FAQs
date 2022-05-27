# Module 3 Project Exercise Hints

<details markdown="1">
<summary markdown="1">
Why isn't my test picking up environment variables?
</summary>

For your app to use environment variables from .env.test, make sure you are accessing them AFTER the test has a chance to read the variables out of .env.test.
If your application code defines `your_constant = os.getenv('YOUR_ENV_VAR')` outside of any function, it will only evaluate **once**, when the file is first imported (before your test has set up the environment).

You should either read the values during `create_app`, or only read the environment variables right before you need them.

</details>

<details markdown="1">
<summary markdown="1">
I'm getting an import error or "Starting path not found" error
</summary>

Your tests folder needs to be recognised as a Python package: add an empty `__init__.py` file to any test directories.

</details>

<details markdown="1">
<summary markdown="1">
Why isn't my integration test using my mock function? I'm still seeing a JSON decode error.
</summary>

Say you have a file, "trello_items.py", which imports requests in this way: `from requests import get`.
Patching `requests.get` (e.g. `monkeypatch.setattr(requests, 'get', stub)`) will have no effect - trello_items already has a reference to the real "get" function.
Either import the whole module instead (use `import requests` in trello_items.py) or patch the function you added to your trello_items module (`monkeypatch.setattr(trello_items, 'get', stub)`).

</details>


<details markdown="1">
<summary markdown="1">
My stub function is giving a TypeError about the arguments.
</summary>

The exact usage of your "stub" function depends on how your application code is trying to use `requests`. 

If your application has a line of code like `requests.get(my_url, headers=my_headers)`, then it must be valid to call `stub(my_url, headers=my_headers)`. Check that your definition of `stub` matches its usage. 

</details>

<details markdown="1">
<summary markdown="1">
My selenium test is failing
</summary>

* If your app depends on environment variables for each list ID, then your selenium test will also need to override those variables with the IDs for the temporary test board's lists.

* Check that your app is using environment variables correctly (not too early and no IDs are hardcoded strings).

</details>
