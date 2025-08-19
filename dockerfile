FROM alpine:latest
RUN curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.9.0/darwin.out -o darwin.out && chmod +x darwin.out && mv darwin.out /usr/bin/darwin
CMD ["darwin", "run_blueprint", "build", "--mode", "folder"]