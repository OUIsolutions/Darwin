#!/bin/bash

# Nome da imagem
IMAGE_NAME="darwin_image"
DOCKERFILE_PATH="dockerfile"
docker build -f "$DOCKERFILE_PATH" -t "$IMAGE_NAME" .


echo "Executando o container..."
docker run --rm -v "$(pwd):/app" -w /app $IMAGE_NAME

gcc release/amalgamation.c -o darwin 
sudo cp darwin /usr/local/bin/darwin2

darwin2 run_blueprint --mode folder build amalgamamation_build