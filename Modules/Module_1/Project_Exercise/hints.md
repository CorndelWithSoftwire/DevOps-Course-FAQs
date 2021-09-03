# Module 1 Project Exercise Hints

Are you seeing any of the below issues?

### I can't run the app

<details><summary>Issues setting up Python?</summary>
//TODO
</details>

<details><summary>Issues setting up Poetry?</summary>
//TODO
</details>

<details><summary>Issues setting up debugging?</summary>
//TODO
</details>

### I can't get the index page to show items?

<details><summary>How do I use `render_template`?</summary>
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

<details><summary>How do I import the existing `get_items` function?</summary>
Take a look at how the project currently imports the `Config` class that's available in the `flask_config.py` file. We can follow a similar structure to import functions, e.g. `from todo_app.data.session_items import get_items`.

If you then wanted to import another function from the same file, we could just add it on the end of that line, separated by a comma:
`from todo_app.data.session_items import get_items, another_function`
</details>

<details><summary>I have an empty template showing, how do I display the items?</summary>
You'll see a hint for where you might put that code in the index template. You're adding that code inside a `<uL>` tag - which represents an "unordered list" - a list of bullet points. [The W3Schools docs](https://www.w3schools.com/tags/tag_ul.asp) can tell us more, and show how we can add list items (`<li>`).

Don't forget we can use Jinja to access variables passed through by `render_template` - it might be worth checking out their [For Loop syntax](https://jinja.palletsprojects.com/en/3.0.x/templates/#for)
</details>

### I can't create new items?

<details><summary>How do I add a form to the page?</summary>
//TODO
</details>

<details><summary>My form isn't triggering my new route?</summary>
//TODO
</details>

<details><summary>How do I use the data passed through from the form?</summary>
//TODO
</details>