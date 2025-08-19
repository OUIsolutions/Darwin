#!/bin/bash

# Nome da imagem
IMAGE_NAME="darwin_image"
DOCKERFILE_PATH="dockerfile"

# Verifica se a imagem já existe
if ! docker image inspect $IMAGE_NAME > /dev/null 2>&1; then
    echo "Construindo a imagem Docker..."
    docker build -f "$DOCKERFILE_PATH" -t "$IMAGE_NAME" .
else
    echo "Imagem Docker já existe."
fi

echo "Executando o container..."
docker run --rm -v "$(pwd):/app" -w /app $IMAGE_NAME

