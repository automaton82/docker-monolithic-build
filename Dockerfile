FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic AS build
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
        gcc build-essential \
        gcc-8 g++-8 \
        python3 python3-dev python3-numpy \
        python3-pip python3-wheel python3-setuptools \
        software-properties-common \
        openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 \
    && ln -s /usr/lib/jvm/java-1.8.0-openjdk-amd64 /usr/lib/jvm/java-1.8.0-openjdk
RUN apt-get update \
    && apt-get --yes --no-install-recommends install sudo tzdata curl \
    && curl 'https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps.sh?format=TEXT' | base64 -d > install-build-deps.sh \
    && chmod 755 install-build-deps.sh \
    && ./install-build-deps.sh --no-arm --no-chromeos-fonts --no-nacl \
    && rm -rf /var/lib/apt/lists/*
