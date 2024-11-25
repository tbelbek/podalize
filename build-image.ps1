# Build the Docker image
docker build -t podalize .

# Tag the Docker image
docker tag podalize tbelbek/podalize:latest

# Push the Docker image to the registry
docker push tbelbek/podalize:latest

# Pull the latest images defined in the docker-compose.yml file
docker-compose pull

# Start the services defined in the docker-compose.yml file in detached mode
docker-compose up -d