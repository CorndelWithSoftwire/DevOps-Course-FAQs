# Module 2 Project Exercise Hints

<details markdown="1">
<summary markdown="1">
How do I know the "status" of an item from Trello? 
</summary>

Each card belongs to a "list". Trello boards are created with the following lists by default: 'To Do', 'Doing', 'Done'.

</details>

<details markdown="1">
<summary markdown="1">
I'm having trouble getting an API call to work or parsing the response
</summary>

You have a few options for investigation (other than trial and error):

* The crudest approach is to add in `print` statements to your app to see what data it is sending/receiving. 
* A fancier version of print statements would be [adding logging](https://www.sentinelone.com/blog/getting-started-quickly-with-flask-logging/)
* To investigate without modifying any code, and without knowing what to look for ahead of time, try **debugging** your app. There are instructions on our [VS Code page](https://corndelwithsoftwire.github.io/DevOps-Course-FAQs/Tools/VSCode.html)

You should check the request you are sending looks correct and that you can find the data you expect in `response.json()`.

</details>

<details markdown="1">
<summary markdown="1">
How can I get all of my cards with a single request to Trello?
</summary>

Take a look at the docs for the [Get Lists on Board endpoint in Trello. ](https://developer.atlassian.com/cloud/trello/rest/api-group-boards/#api-boards-id-lists-get) - are there any helpful looking query parameters?

In particular, notice the `cards` parameter - if we supply that with the value "all" then we should get back a list of the lists on our board, with all of their cards also included!

We could then process those with something like:
```python
result = requests.get("<trello_endpoint>", params = params).json()
for list in lists:
    for card in list['cards']:
        # process that particular card
```
</details>
