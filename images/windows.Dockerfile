FROM debian:latest


RUN apt-get update && \
    apt-get install -y \
    mingw-w64 && \
    apt-get clean && \
    curl && \
    rm -rf /var/lib/apt/lists/*


    RUN  curl -L https://github.com/OUIsolutions/Darwin/releases/download/v0.016/darwin.out -o /usr/local/bin/darwin
    RUN chmod +x /usr/local/bin/darwin

CMD ["sh", "-c", "cd project && darwin run_blueprint build/ --mode folder build_windows"]
