# Module 4 Project Exercise Hints

<details markdown="1">
<summary markdown="1">

## How can I install a specific version of Python?

</summary>

Here are example instructions to install Python from source in case you need a more recent version than that provided by yum. Your playbook should check whether Python is already installed before running these commands.

### 1. Install Dependencies
```sh
sudo yum update -y
sudo yum groupinstall "Development Tools" -y
# If installing a version of Python < 3.10, then use openssl-devel in place of openssl11-devel
sudo yum install libffi-devel bzip2-devel wget openssl11-devel -y
```

### 2. Download, unzip, cd
```sh
wget https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tgz
tar -xf Python-3.10.2.tgz
cd Python-3.10.2/
```

### 3. Build and install it
```sh
sudo ./configure --enable-optimizations
sudo make -j $(nproc)
sudo make altinstall # or "sudo make install" to override existing Python
```
</details>

<details markdown="1">
<summary markdown="1">

## Why isn't "poetry install" working?

</summary>

When you try to run a command like `poetry install`, how does the computer recognise "poetry"? It looks at your `PATH` environment variable. This is a list of folders and your shell will search each one for a file called "poetry".

When you installed Poetry, the installer added a line to the ec2-user's ".bash_profile" file, which adds the location of Poetry to the PATH environment variable. Run `cat ~/.bash_profile` if you want to see it.

That .bash_profile file is executed automatically when you log into to the VM. So if you manually SSH onto the VM and run "poetry install", the shell finds a matching executable in the PATH and everything works. But Ansible's "shell" module will not run the ".bash_profile" file before running your command. So if you try running the simple command `poetry install`, you will get an error saying that "poetry" was not found.

The solution we suggest is to reference poetry by its full filepath instead of relying on the PATH environment variable.

</details>
