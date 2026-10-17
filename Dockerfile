# Use a Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install necessary dependencies including git and perl
RUN apt-get update && apt-get install -y git perl && rm -rf /var/lib/apt/lists/*

# Copy the entire project into the container
COPY . /app

# Ensure the entrypoint script is executable
RUN chmod +x /app/.github/scripts/entrypoint.sh

# Run the entrypoint script when the container starts
ENTRYPOINT ["/bin/bash", "/app/.github/scripts/entrypoint.sh"]
