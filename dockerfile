FROM ubuntu:latest
RUN apt update
RUN apt install -y curl 
RUN apt install -y git 
RUN curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.9.0/darwin.out -o darwin.out && chmod +x darwin.out && mv darwin.out /usr/bin/darwin
CMD ["/usr/bin/darwin", "run_blueprint", "build/", "-mode", "folder", "amalgamation_build"]