# VSCode

Visual Studio Code is a free Microsoft-supported IDE that is designed to work with a wide range of languages and tools, and can be extended even further using community written extensions. It will be our primary IDE throughout the course.

<details markdown="1">
<summary markdown="1">
How to set up VSCode
</summary>

[Watch our video](https://nextcloud.softwire.com/index.php/s/zFGpDfyxS9keELT) for more advice on how to set up your VSCode instance.
</details>

<details markdown="1">
<summary markdown="1">
What's debugging?
</summary>

You can run your Python code in "debug mode", meaning that you can interrupt the execution at any line of your choosing. While the execution is paused, you can look at the values of variables, or even run Python commands in an interactive terminal with all the variables and functions available to you at that point in the file.

To try it out, write a simple Python file and save it. Then click in the margin to the left-hand side of a line so that a red dot appears. This is called adding a **breakpoint**. You can set as many as you like. For example:

<img src="https://user-images.githubusercontent.com/10462681/177747232-77c71771-742c-42ff-ba30-5b5969f2dfb5.png" alt="breakpoint" height="300"/>

Then select "Debug Python File" via the dropdown in the top right of the screen:

<img src="https://user-images.githubusercontent.com/10462681/177747560-6185c212-5c12-485c-8305-22793f3c78a6.png" alt="breakpoint" height="300"/>

Execution will pause at your breakpoint, just before that line executes. A bar like this should appear to give you control over what happens next:

<img src="https://user-images.githubusercontent.com/10462681/177748269-4be9431a-5890-4e84-8573-a416f7abbb4c.png" alt="breakpoint" height="80"/>

The six buttons from left to right are:
* "Continue" - let your Python code continue executing. It will only pause if it hits another breakpoint.
* "Step Over" - let the current line execute and then the debugger will pause at the next line down
* "Step Into" - if you are calling a function on the current line, the debugger will move into that function and pause on the first line of it. Otherwise it just steps over.
* "Step Out" - let the current function complete and then pause where the function was called from. If you aren't in a function, it will just continue to completion.
* "Restart"
* "Stop"

Those controls let you watch how the code executes. Other IDEs will have the same set of controls. Try it out with your file to get a feel for it. But you can do more!
* Hover your mouse over variables to check their values, or look them up in the list in the top left  
* Use the "Debug Console" tab at the bottom of the screen as an interactive Python terminal to execute any code you want. You can even modify a variable and then watch how the code executes in that scenario.
 
So in the example above, you could run `foo = 30` in the Debug Console, see the value change and then click "Step Over" and watch the debugger move to the `else` block.

There are some further features of the debugger, but this is enough to start debugging effectively. 

</details>

<details markdown="1">
<summary markdown="1">
How do I run my Flask app "in debug mode"?
</summary>

If your `app.py` file contains the following code, you should be able to run it in debug mode with the button in the top right as described above. Execution will also pause at breakpoints set in other files

```python
if __name__ == '__main__':
    app.run()
```

Alternatively, if you don't want to include that code, or if you don't want to open app.py each time, you can add a debug "configuration" to your VS Code project: 

* Open up any Python file
* Select "Run and Debug" from the Activity Bar, i.e click on the play button with a bug from the list of icons on the left-hand side of VS Code
* Click on `create a launch.json file`
  * If you already have a launch configuration for whatever reason, select `Add Configuration` via the dropdown at the top, and then select Python from the list of options that appears
* Select `Flask` from the dropdown that appears at the top of the screen
* Enter `todo_app/app.py` instead of just the default `app.py`
* Click the play button from the top of the "Run and Debug" panel to start it up. If you have multiple launch configurations, make sure that "Python: Flask" is selected.

You should see your app start up. Try adding a breakpoint and then use your site as normal. Execution should pause at your breakpoint and the page won't load in the browser until you allow it to continue. 

</details>
