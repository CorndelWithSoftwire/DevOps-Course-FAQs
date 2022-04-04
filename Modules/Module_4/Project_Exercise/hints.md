# Module 4 Project Exercise Hints

<details markdown="1">
<summary markdown="1">
How can I install a specific version of Python?
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