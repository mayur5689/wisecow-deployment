# Use Ubuntu as base image
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install required packages
RUN apt-get update && \
    apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Set cowsay path (it's installed in /usr/games/)
ENV PATH="/usr/games:${PATH}"

# Create app directory
WORKDIR /app

# Copy the wisecow script
COPY wisecow.sh .

# Make script executable
RUN chmod +x wisecow.sh

# Expose port 4499
EXPOSE 4499

# Run the application
CMD ["./wisecow.sh"]
