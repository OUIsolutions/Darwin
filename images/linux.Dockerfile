
FROM alpine:latest

RUN apk update
RUN apk add --no-cache gcc musl-dev curl
# Copie os scripts necessários
RUN  curl -L https://github.com/OUIsolutions/Darwin/releases/download/v0.016/darwin.out -o /usr/local/bin/darwin
RUN chmod +x /usr/local/bin/darwin

CMD ["sh", "-c", "cd project && darwin run_blueprint build/ --mode folder build_linux"]
