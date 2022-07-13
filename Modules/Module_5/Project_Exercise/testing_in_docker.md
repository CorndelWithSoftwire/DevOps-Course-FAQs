# Python Tests in Docker

This document guides you through setting up testing in Docker. You'll mostly be expanding the Dockerfile you wrote in the core Module 5 exercise, but you may also need to adjust your Python test code to work smoothly in Docker.

First, you need a Docker image that can run pytest. The aim is to be able to run your test suites using `docker run`:

```bash
# Run tests
$ docker run <options> my-test-image tests
=========================== test session starts ===========================
platform linux -- Python 3.8.5, pytest-6.0.1, py-1.9.0, pluggy-0.13.1
rootdir: /app
collected 25 items

my/test/directory/test_stuff.py                                      [100%]

=========================== 11 passed in 0.49s ============================
```

## Part 1: Add a new build stage

You already have a multi-stage Docker build with development and production stages. Now add a third stage for testing. Call it test. In the end you'll have an outline that looks like the one below:

```dockerfile
# Common setup steps
FROM python:3.8-slim-buster as base
...

# production build stage
FROM base as production
...

# local development stage
FROM base as development
...

# testing stage
FROM base as test
...

ENTRYPOINT ["poetry", "run", "pytest"]
```

You'll notice we've filled in the ENTRYPOINT instruction to launch pytest. You can do the same.

## Part 2: Get Pytest Working

Use your Dockerfile as shown below to see if it works. Note how we're passing an argument to pytest directly from the `docker run` command.

```bash
# Build it
$ docker build --target test --tag my-test-image .

# Run tests in the "tests" directory
$ docker run my-test-image
```

Depending on your existing Dockerfile, your image might fail at different stages. Look carefully at any error messages, how far does it get?
1. Can Docker run Poetry?
2. Can Poetry launch pytest? Check all of your dependencies are getting installed
3. Can pytest find your tests? Check that they are copied into the image.
4. Can your tests find your application code? A common cause of failure here is missing an `__init__.py` file in your test directories - make sure to include one!

Don't worry if the test cases fail - we'll come to that in a moment but take some time to work through the steps above. The test image should at least be at a stage where it launches pytest and finds your application code. 

If you have end-to-end tests, put them in a different directory from the rest of your tests. Then the two sets of tests can be run in separate commands. For example if you call the two folders "tests" and "tests_e2e", then you would use these commands:
- `docker run my-test-image tests`
- `docker run my-test-image tests_e2e`

Anything after the image name is setting the CMD for the container. When you have ENTRYPOINT and a CMD, the CMD gets joined to the end of the ENTRYPOINT. So these commands run containers that execute "poetry run pytest tests" and "poetry run pytest tests_e2e". 

## Part 3: Unit and Integration Tests

Your unit and integration tests should now run in Docker. Make sure they do! If you hit any errors, now is the time to investigate and fix them.

Your test cases might fail because the integration test needs to load environment variables. Either make sure to copy your `.env.test` file into the image, or provide the file as part of your "docker run" command.

To provide the file to "docker run", use the `--env-file` option. You have to provide the filename, e.g. `--env-file .env.test`. Remember that "docker run" options must come before the image name! Anything after the image name is the contianer's CMD.

<details markdown="1"><summary>Is your test failing to load .env.test?</summary>
On some machines, you may find that pytest is unable to use the load_dotenv function inside Docker. Work around that fact by handing the exception and passing in the .env.test file in your "docker run" command instead.

```python
    try:
        file_path = find_dotenv('.env.test')
        load_dotenv(file_path, override=True)
    except OSError:
        print('Failed to load dotenv')
```

Alternatively, if you see an error suggesting that Python is trying to load your `.env.test` file from a path matching your host machine (for example, `C:\DevOps\DevOps-Course-Starter\.env.test` or anything with your username in) this might suggest that some cached information from your host has been transferred inside your container. Ensure you have a `.dockerignore` file with the following entries to avoid that, and rebuild your image:
```
**/__pycache__
**/.pytest_cache
```
</details>

## Part 4: Selenium in Docker

If you have selenium end-to-end tests, you can run those in your Docker container too, but you'll need a supported webdriver and browser. You can have a go at this yourself, but it can be a little fiddly. To help, here's a Dockerfile snippet that installs Firefox and geckodriver.

```dockerfile
ENV GECKODRIVER_VER v0.31.0
 
# Install the long-term support version of Firefox (and curl if you don't have it already)
RUN apt-get update && apt-get install -y firefox-esr curl
  
# Download geckodriver and put it in the usr/bin folder
RUN curl -sSLO https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VER}/geckodriver-${GECKODRIVER_VER}-linux64.tar.gz \
   && tar zxf geckodriver-*.tar.gz \
   && mv geckodriver /usr/bin/ \
   && rm geckodriver-*.tar.gz
```

The pytest fixture below shows one approach to launching selenium with Firefox within Docker.

```python
from selenium.webdriver.firefox.options import Options

@pytest.fixture(scope='module')
def driver():
    opts = Options()
    opts.headless = True
    with webdriver.Firefox(options=opts) as driver:
        yield driver
```

<details markdown="1"><summary>Alternatively, you can use Chrome if you prefer. Expand this for code snippets.</summary>

```Dockerfile
RUN apt-get update -qqy && apt-get install -qqy wget gnupg unzip
# Install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install Chrome driver that is compatible with the installed version of Chrome
RUN CHROME_MAJOR_VERSION=$(google-chrome --version | sed -E "s/.* ([0-9]+)(\.[0-9]+){3}.*/\1/") \
  && CHROME_DRIVER_VERSION=$(wget --no-verbose -O - "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION}") \
  && echo "Using chromedriver version: "$CHROME_DRIVER_VERSION \
  && wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && unzip /tmp/chromedriver_linux64.zip -d /usr/bin \
  && rm /tmp/chromedriver_linux64.zip \
  && chmod 755 /usr/bin/chromedriver
```

And here are the options you need in your Python code:

```python
@pytest.fixture(scope='module')
def driver():
    opts = webdriver.ChromeOptions()
    opts.add_argument('--headless')
    opts.add_argument('--no-sandbox')
    opts.add_argument('--disable-dev-shm-usage')
    with webdriver.Chrome(options=opts) as driver:
        yield driver
```

</details>

Try updating your Dockerfile and test file, then rebuild the image and run the end-to-end tests.

<details markdown="1"><summary>Selenium test failing?</summary>

Common issues:
- Make sure you are not copying your own geckodriver or chromedriver file into the image
- The possible issue with load_dotenv from part 2 applies to your selenium test as well 
- Your .env file should not copied into the Dockerfile, so make sure to provide it as part of the "docker run" command correctly. You can also provide individual environment variables with the `-e` option. For example `docker run -e TRELLO_KEY=foo -e TRELLO_TOKEN=bar my-test-image tests_e2e`
- Check your credentials are set in the .env file correctly. Docker is stricter than load_dotenv - the `.env` file is not a Python file and should have lines of the form `FOO=bar` without quotes around the value or spaces around the equals sign. Check there are no trailing spaces at the end of lines either!

</details>

## Congratulations!

You can now run your unit, integration and end-to-end tests within Docker! Document the fact in your README file. You can use this as a convenient way to run tests locally, or on any platform that supports Docker which will include your CI platform in Module 7.
