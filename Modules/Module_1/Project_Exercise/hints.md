# Module 1 Project Exercise Hints

Are you seeing any of the below issues?

### Review Process

<details markdown="1">
<summary markdown="1">
Who are the reviewers?
</summary>

Please add the following Github users as collaborators:
* Stephen Shaw (`aeone`)
* Alex Jones (`Jonesey13`)
* Jack Mead (`JackMead`)
* Ben Ramchandani (`BenRamchandani`)
* Josh Powell (`JoshAdamPowell`)
* Andrew Huang (`AndrewYHuang`)
* `CorndelExcellence`
* `CorndelWithSoftwireDevOps`

If you're using GitLab instead, then please add the following and assign them "Maintainer" permissions:
* Stephen Shaw (`aeone`)
* Alex Jones (`Jonesey13`)
* Jack Mead (`JackMead`)
* Ben Ramchandani (`Ben.Ramchandani`)
* Josh Powell (`JoshAdamPowell`)
* Andrew Huang (`AndrewYHuang`)
</details>

### I can't run the app

<details markdown="1">
<summary markdown="1">
Issues setting up Python?
</summary>

Try following the guide to installing Python on [the Python Intro repository](https://github.com/CorndelWithSoftwire/DevOps-Course-Python-Intro)
</details>

<details markdown="1"><summary markdown="1">Issues setting up Poetry?
</summary>

The course starter repo should contain advice on installing Poetry, or you can follow the [official Poetry docs](https://python-poetry.org/docs/#installation).
This should install and configure Poetry - try closing down any terminals you have open, and when you open a fresh one the command `poetry --version` should print out a version number something like:
```
Poetry version 1.1.7
```
If it does, congratulations - it looks like Poetry is installed correctly! If you're still having issues, you might want to look at [the Poetry FAQs](Tools/poetry.md).

If it states something like `poetry: command not found` then it looks like that hasn't quite installed correctly. The first thing we should do is check if the file appears to have downloaded correctly - it should have created a `.poetry` folder in your user area. E.g. on Windows, look at "C:\\Users\\\<YourName\>" and see if the `.poetry` folder exists (making sure you can see hidden folders!) - if it does click into it, then into the `bin` folder and check that a file exists there called `poetry`. On a Mac, follow the same process but starting in your user area (e.g. `/Users/\<YourName\>).

If that file is missing, then it looks like the Poetry installation script didn't work as expected. You could try re-running that and seeing if there are any hints or errors in the output, or alternatively reach out to a tutor who will be able to help debug further.

If the file is present, then it's probably just missing from your PATH environment variable - a user setting that helps the terminal know what programs are available to run. You'll want to add the "bin" folder to your path, e.g. "C:\\Users\\\<YourName\>\\.poetry\\bin" or "/Users/\<YourName\>/.poetry/bin" depending on whether you're on Windows/Mac respectively
* On Windows, [see this guide for adding a folder to your PATH](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/)
* On Mac, [see this guide for adding a folder to your PATH](https://wpbeaches.com/how-to-add-to-the-shell-path-in-macos-using-terminal/)

If the poetry folder is in your PATH and it is still not being picked up in a VSCode terminal (but works in standalone terminal) then should you try:
1. Restarting VSCode (to reload the PATH variable)
1. Creating a new terminal in VSCode (sometimes VSCode likes to keep old terminal sessions after a restart)

</details>

<details markdown="1">
<summary markdown="1">
Issues with VSCode?
</summary>

See [our VSCode docs](/Tools/VSCode.md) for more information regarding setting it up generally, or [watch our video](https://nextcloud.softwire.com/index.php/s/xDNY7TDe4wxMg9s) for more advice on setting up VSCode explicitly for the project exercise project.
</details>

### I can't get the index page to show items?

<details markdown="1">
<summary markdown="1">
How do I use `render_template`?
</summary>

`render_template` is Flask's solution for building & returning the correct HTML to a users request. You can see an [example of using it in Flask's documentation](https://flask.palletsprojects.com/en/1.1.x/quickstart/#rendering-templates). The first argument it takes is the relative filepath of the template file from your templates folder - if you were trying to reference a template under `templates/home/my_homepage.html` then you'd pass in "home/my_homepage". Using just the name of your homepage template, can you get your app to show an empty index page? (Don't forget that you'll need to import the function from Flask!)

Any other arguments passed into the `render_template` function will be made available to Jinja when building the HTML. So e.g. from the Flask example:
```python
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello.html', your_name=name)
```

The value of the name passed in as part of the route will be available in the template under the name `your_name`:
```html
<div>Hello there {{ your_name }}</div>
```

Note that the key for that argument (in this case, `your_name`) can be (almost) anything you choose - it's just how you'll refer to that variable in the template. It's common to have it match the variable name being passed in (e.g. `render_template('hello.html', name=name)`).
</details>

<details markdown="1">
<summary markdown="1">
How do I import the existing `get_items` function?
</summary>

Take a look at how the project currently imports the `Config` class that's available in the `flask_config.py` file. We can follow a similar structure to import functions, e.g. `from todo_app.data.session_items import get_items`.

If you then wanted to import another function from the same file, we could just add it on the end of that line, separated by a comma:
`from todo_app.data.session_items import get_items, another_function`
</details>

<details markdown="1">
<summary markdown="1">
I have an empty template showing, how do I display the items?
</summary>

You'll see a hint for where you might put that code in the index template. You're adding that code inside a `<uL>` tag - which represents an "unordered list" - a list of bullet points. [The W3Schools docs](https://www.w3schools.com/tags/tag_ul.asp) can tell us more, and show how we can add list items (`<li>`).

Don't forget we can use Jinja to access variables passed through by `render_template` - it might be worth checking out their [For Loop syntax](https://jinja.palletsprojects.com/en/3.0.x/templates/#for)
</details>

### I can't create new items?

<details markdown="1">
<summary markdown="1">
How do I add a form to the page?
</summary>

The example form below submits the users first & last names:
```html
<form action="/route" method="POST">
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" name="fname" value="John"><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lname" name="lname" value="Doe"><br><br>
  <input type="submit" value="Submit">
</form>
```

Note that the form has:
* An action - the route that this form is supposed to trigger
* A method - the HTTP method that should be used. GET or POST are the only supported options
* Inputs - in this case of type "text" to allow the user to enter text
  * These each have an "id" (to identify them in the HTML) and a "name" (to identify the fields that are submitted)
* Labels - these are text to describe what should be placed in a corresponding input - note that they are semantically linked with the "for" field to match an input's corresponding "id" field
* A way to submit it - in this case an input of type "submit", but optionally a button of type "submit" would also work

For further info, take a look at [W3Schools' page on forms](https://www.w3schools.com/html/html_forms.asp)
</details>

<details markdown="1">
<summary markdown="1">
How do I use the data passed through from the form?
</summary>

If you import the `request` module from Flask, `request.form` will allow you to access a dictionary of values that were passed through in a form. You can [see the docs for that here](https://flask.palletsprojects.com/en/2.0.x/api/#flask.Request.form) or there's a simple example of using that below:

```python
from flask import Flask, request # other dependencies

# define app, set up index etc.

@app.route("/receive_form", methods=["POST"])
def receive_form():
    form_value = request.form["my-named-input"]
    # Do something with that value
```

If you're having issues with that, it's worth checking:
* Is that route being hit at all? You could try adding a breakpoint or a print statement to check if `receive_form` is being triggered. If not:
  * Is the form's [action attribute](https://www.w3schools.com/tags/att_form_action.asp) pointing to the right route?
  * Have you set the form's [method attribute](https://www.w3schools.com/tags/att_form_method.asp) to match the route?
* If the route's hit but the value doesn't seem to be there, have you got a naming mismatch? E.g. if you print or inspect the `request.form` value - does it have anything in it?
  * Note that you'll need to specify the [input's name attribute](https://www.w3schools.com/tags/att_input_name.asp)
</details>

### The above haven't helped?


<details markdown="1">
<summary markdown="1">
Where else can I look?
</summary>

[This linked video](https://nextcloud.softwire.com/index.php/s/xDNY7TDe4wxMg9s) contains a walk-through for the first project exercise including set up, so might be able to help you with any questions not covered by the above. Don't forget to also reach out to the trainers via Slack, Teams, Email or by booking a support call if you're seeing issues and we'll be more than happy to help!
</details>
