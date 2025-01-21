FROM debian:latest


RUN apt-get update && \
    apt-get install -y \
    mingw-w64 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


CMD ["sh", "-c", "cd project && ./darwin.out build build/darwinconf.lua build_windows"]
