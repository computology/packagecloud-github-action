FROM ubuntu:focal
SHELL ["/bin/bash", "-l", "-c"]

RUN apt-get update

# Required to download things from internet
RUN apt-get install -y curl

# Install build tools required for building native extensions
RUN apt-get install -y build-essential

# Required for apt-add-repository
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common

# Connect to repo that contains all python versions
RUN add-apt-repository -y ppa:deadsnakes/ppa


# Install python3.7
RUN apt-get install -y python3-setuptools
RUN apt-get install -y python3.7
RUN apt-get install -y python3.7-distutils
RUN curl -fsSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.7 get-pip.py

# Install rvm
RUN  gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby
RUN source /usr/local/rvm/scripts/rvm
RUN rvm install 2.7.5
RUN rvm use 2.7.5 && gem install package_cloud

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
