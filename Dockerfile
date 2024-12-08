FROM debian:latest


RUN apt-get update && \
    apt-get install -y \
    curl \
    gcc \
    gcc-multilib \
    git \
    mingw-w64 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



