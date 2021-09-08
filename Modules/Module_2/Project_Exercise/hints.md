# Module 2 Project Exercise Hints

<details><summary>How can I get all of my cards with a single request to Trello?</summary>

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