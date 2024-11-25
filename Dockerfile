# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh \
    && bash /miniconda.sh -b -p /opt/conda \
    && rm /miniconda.sh

# Update PATH environment variable
ENV PATH=/opt/conda/bin:$PATH

# Create a conda environment and install dependencies
COPY environment.yml /app/environment.yml
RUN conda env create -f environment.yml

# Set environment variables
ENV PATH2AUDIOS=/app/data
ENV PATH2LOGS=/app/data/logs
ENV VERBOSE=False

# Expose the port the app runs on
EXPOSE 8501

# Run the application
CMD ["/bin/bash", "-c", "source activate podalize && streamlit run podalize_app.py"]