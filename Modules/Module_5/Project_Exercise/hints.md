# Module 5 Project Exercise Hints

Are you seeing any of the below issues?

### Docker isn't working

<details markdown="1">
<summary markdown="1">
If you can't run any Docker commands
</summary>

First, check that Docker is installed; does `docker --help` return anything? If not, make sure you've completed the installation steps detailed [on Docker's website](https://docs.docker.com/get-docker/)

Next, check Docker is running. Errors like the below indicate that Docker probably hasn't started. If you open Docker Desktop, you should see a green light indicator at the bottom left to confirm Docker is running successfully.
```
error during connect: This error may indicate that the docker daemon is not running.: Post "http://%2F%2F.%2Fpipe%2Fdocker_engine/v1.24/build?buildargs=%7B%7D&cachefrom=%5B%5D&cgroupparent=&cpuperiod=0&cpuquota=0&cpusetcpus=&cpusetmems=&cpushares=0&dockerfile=Dockerfile&labels=%7B%7D&memory=0&memswap=0&networkmode=default&rm=1&shmsize=0&target=&ulimits=null&version=1": open //./pipe/docker_engine: The system cannot find the file specified.
```

You may be able to resolve this just by restarting Docker or running it as an administrator.

If you're still having issues and are on Windows using wsl to back Docker, it's worth running through the [WSL specific instructions](https://docs.docker.com/desktop/windows/install/#wsl-2-backend) again to check you've done everything; for example it's easy to overlook installing the Linux Kernel update package mentioned.
</details>

### Problems building an image?

<details markdown="1">
<summary markdown="1">
Package/Image is missing on an M1-chip Mac
</summary>

Not all base images/packages are available yet for M1 chips, so you may have to look for alternatives. If you're having issues here, definitely reach out to a trainer as we may have seen other learners hit this issue!
</details>

<details markdown="1">
<summary markdown="1">
Image fails to build
</summary>

First, establish which command in your Dockerfile is causing the issue; does the error itself provide any hints for how to proceed?

If not, a useful step to take can be to build your image up until that command, and then interactively investigate. For example, suppose the following Dockerfile errored on the RUN command:
```
FROM python
WORKDIR src
RUN pip install flask
COPY code .
ENTRYPOINT flask run
```

We could temporarily reduce it down to just the base image, and add an entrypoint to open a shell session; we can then build the image (`docker build --tag explore .`) and run it interactively (`docker run -it explore`) and see whether exploring within the shell helps
```
FROM python
ENTRYPOINT bash
# WORKDIR src
# RUN pip install flask
# COPY code .
# ENTRYPOINT flask run
```
</details>

### Problems running your containers?
<details markdown="1">
<summary markdown="1">
The container runs, but I see JSON Decode errors when I try to access it
</summary>

You're likely to be seeing these errors because Trello is not returning JSON to your requests. This is often the case because Trello is not accepting your request as valid, potentially because it does not recognise your Key & Token. Are you passing through your environment variables (e.g. with `docker run --env-file .env <image>`)?

If you are, another avenue to explore is what value the environment variables are taking within your container - are they what you'd expect? Importantly, Docker does not expect quotes to surround values in a `.env` file, whereas Python-Dotenv is forgiving on this. Ensure your `.env` file doesn't have quotes around values:
```
# Like this
KEY=keyvalue
# Not this
KEY="keyvalue"
```
</details>